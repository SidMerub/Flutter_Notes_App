import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:voicenotesapp/constants/constants.dart';
import 'package:voicenotesapp/utils/utilities.dart';
import 'package:voicenotesapp/widgtes/detailsField.dart';
import 'package:voicenotesapp/widgtes/titleField.dart';

class EditNote extends StatefulWidget {
  const EditNote({Key? key}) : super(key: key);

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  final titleController = TextEditingController();
  final detailsController = TextEditingController();
  late DateTime dateTime;
  late String time;
  late String noteID;

   @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final arguments = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    titleController.text = arguments['note']['title'] as String;
    detailsController.text = arguments['note']['details'] as String;
    dateTime = arguments['note']["createdAt"].toDate();
    time = "${dateTime.day}/${dateTime.month}/${dateTime.year}  ${dateTime.hour}:${dateTime.minute}";
    noteID = arguments['noteID'];
  }



  editNote() async {
    await FirebaseFirestore.instance.collection("notes").doc(noteID).update({
      "title": titleController.text,
      "details": detailsController.text,
    });
   Utils().toasteMessage('Note Edited');
    Navigator.pop(context);


  }

  deleteNote() async {
    await FirebaseFirestore.instance.collection("notes").doc(noteID).delete();
   Utils().toasteMessage('Note Deleted');
    Navigator.pop(context);


  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: theme.background,
      appBar: AppBar(
        backgroundColor: darkShadow,
        centerTitle: true,
        title: Text(time, style: GoogleFonts.jetBrainsMono(color: theme.onBackground, fontSize: 16)),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: editNote,
            color: theme.onPrimaryContainer,
          ),
        IconButton(onPressed: deleteNote, icon: const Icon(Icons.delete))
        ],
        iconTheme: IconThemeData(color: theme.onBackground),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TitleField(controller: titleController, focus: false),
              DetailsField(controller: detailsController)
            ],
          ),
        ),
      ),

    );
  }
}
