import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:voicenotesapp/constants/constants.dart';
import 'package:voicenotesapp/provider/Deleteprovider.dart';

class MultiDeleteNotes extends StatefulWidget {
  const MultiDeleteNotes({Key? key}) : super(key: key);

  @override
  State<MultiDeleteNotes> createState() => _MultiDeleteNotesState();
}

class _MultiDeleteNotesState extends State<MultiDeleteNotes> {
  User? userId = FirebaseAuth.instance.currentUser;
  List<String> noteIds = [];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final notesProvider = Provider.of<NotesProvider>(context);

    return Scaffold(
      backgroundColor: theme.background,
      appBar: AppBar(
        backgroundColor: darkShadow,
        centerTitle: true,
        title: Text(
          '${notesProvider.selectedNotes.length} Selected',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        actions: [
          Checkbox(
            value: notesProvider.selectedNotes.length == noteIds.length &&
                notesProvider.selectedNotes.length > 0,
            onChanged: (value) {
              if (value!) {
                notesProvider.selectAllNotes(noteIds);
              } else {
                notesProvider.clearSelection();
              }
            },
          ),
        ],
        actionsIconTheme: IconThemeData(color: theme.onPrimaryContainer),
      ),
      bottomNavigationBar: notesProvider.selectedNotes.isNotEmpty
          ? BottomAppBar(
        color: darkShadow,
        child: Container(
          padding: const EdgeInsets.all(8),
          child: ElevatedButton(
            onPressed: () {
              deleteSelectedNotes(context);
            },
            child: Icon(Icons.delete),
          ),
        ),
      )
          : null,
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("notes")
              .orderBy("createdAt", descending: true)
              .snapshots(),
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

            noteIds = snapshot.data!.docs.map((note) => note.id).toList();

            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final note = snapshot.data!.docs[index];
                  DateTime dateTime = note["createdAt"].toDate();
                  if (note['uid'] != null && note['uid'] == userId?.uid) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              lightShadow,
                              lightPrimary,
                              darkPrimary,
                              darkShadow
                            ],
                          ),
                        ),
                        child: ListTile(
                          leading: Checkbox(
                            value: notesProvider.selectedNotes.contains(note.id),
                            onChanged: (value) {
                              notesProvider.toggleNoteSelection(note.id);
                            },
                          ),
                          title: Text(note['title']),
                          subtitle: Text(
                            "${dateTime.day}/${dateTime.month}/${dateTime.year}  ${dateTime.hour}:${dateTime.minute}",
                            style: GoogleFonts.jetBrainsMono(fontSize: 12),
                          ),
                        ),
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
  void deleteSelectedNotes(BuildContext context) {
    final provider = context.read<NotesProvider>();
    for (String noteId in provider.selectedNotes) {
      FirebaseFirestore.instance.collection("notes").doc(noteId).delete();
    }

    provider.selectedNotes = [];
  }
}

