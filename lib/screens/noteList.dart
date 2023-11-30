import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voicenotesapp/constants/constants.dart';
import 'package:voicenotesapp/provider/favourite_provider.dart';
import 'package:voicenotesapp/screens/addNote.dart';
import 'package:voicenotesapp/screens/editNote.dart';
import 'package:voicenotesapp/screens/multideletenotes.dart';
import 'package:voicenotesapp/widgtes/actionAlert.dart';
import 'package:voicenotesapp/widgtes/noteTile.dart';

class NoteList extends StatefulWidget {
  const NoteList({Key? key}) : super(key: key);

  @override
  State<NoteList> createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  TextEditingController searchController = TextEditingController();
  User? userId = FirebaseAuth.instance.currentUser;

  signOut() {
    showDialog(
      context: context,
      builder: (context) {
        return ActionAlert(
          title: 'LogOut',
          content: 'You will be logged out but your data will not be erased',
          onTap: () {
            FirebaseAuth.instance.signOut();
            Navigator.pop(context);
            final snackBar = SnackBar(
              content: const Text(
                'User Logged Out!',
                style: TextStyle(fontSize: 16),
              ),
              backgroundColor: Theme.of(context).colorScheme.secondary,
              dismissDirection: DismissDirection.down,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          },
          actionText: 'Logout',
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final favouriteProvider = Provider.of<FavouriteItemProvider>(context);
    final theme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: theme.background,
      appBar: AppBar(
        backgroundColor: darkShadow,
        centerTitle: true,
        title: Text(
          'QuickNote',
          style: TextStyle(
            color: theme.onPrimaryContainer,
            fontWeight: FontWeight.w600,
            fontSize: 24,
          ),
        ),
        actions: [
          IconButton(onPressed: signOut, icon: const Icon(Icons.logout_outlined)),
        ],
        actionsIconTheme: IconThemeData(color: theme.onPrimaryContainer),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: TextField(
                controller: searchController,
                onChanged: (query) {
                  favouriteProvider.updateSearchQuery(query.toLowerCase());
                },
                decoration: InputDecoration(
                  hintText: 'Search Notes',
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear, color: Colors.grey),
                    onPressed: () {
                      searchController.clear();
                      favouriteProvider.updateSearchQuery('');
                    },
                  ),
                  border: InputBorder.none,
                ),
              ),

            ),
          ),
        ),
      ),

      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButton: FloatingActionButton(
        backgroundColor: darkShadow,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddNote()),
          );
        },
        child: const Icon(Icons.add),
      ),

      /*floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddNote()),
          );
        },
        label: const Text('Add Note', style: TextStyle(fontSize: 16)),
        icon: const Icon(Icons.add_rounded),
        elevation: 0,
      ),*/

      body: Padding(
        padding: const EdgeInsets.all(8),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("notes").orderBy("createdAt", descending: true).snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(child: Text('Something went wrong'));
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.data!.docs.isEmpty) {
              return const Center(child: Text('Oops!\nNo Notes Available'));
            }
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final note = snapshot.data!.docs[index];
                  DateTime dateTime = note["createdAt"].toDate();
                  if (note['uid'] != null && note['uid'] == userId?.uid &&
                      (favouriteProvider.searchQuery.isEmpty ||
                          note['title'].toString().toLowerCase().contains(favouriteProvider.searchQuery.toLowerCase()))) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: NoteTile(
                        title: note['title'],
                        date: "${dateTime.day}/${dateTime.month}/${dateTime.year}  ${dateTime.hour}:${dateTime.minute}",
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const EditNote(),
                              settings: RouteSettings(
                                arguments: {'note': note, 'noteID': note.id},
                              ),
                            ),
                          );
                        },
                        onLongPress: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MultiDeleteNotes(),
                            ),
                          );
                        },
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}