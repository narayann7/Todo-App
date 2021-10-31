// ignore_for_file: prefer_const_constructors
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todoapp/all_constant.dart';

editToDo(BuildContext context, DocumentSnapshot documentSnapshot) {
  CollectionReference todos =
      FirebaseFirestore.instance.collection('todoscollection');
  String? todo = documentSnapshot['todo'];
  TextEditingController editToDo = TextEditingController(text: todo);
  String str = editToDo.text;
  Widget okButton = TextButton(
    child: text("Ok", 15),
    onPressed: () {
      if (str != editToDo.text) {
        todos.doc(documentSnapshot.id).update({
          "todo": editToDo.text,
          "status": false,
        });
      }

      Navigator.pop(context);
    },
  );
  Widget cancleButton = TextButton(
    child: text("Cancel", 15),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  AlertDialog alert = AlertDialog(
    backgroundColor: background,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12.0))),
    title: text("edit todo", 25),
    content: TextField(
      controller: editToDo,
      cursorColor: black,
      decoration: InputDecoration(disabledBorder: InputBorder.none),
    ),
    actions: [okButton, cancleButton],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

text(String content, double size) {
  return Text(
    content,
    style: GoogleFonts.getFont('Sen', fontSize: size, color: black),
  );
}

deleteToDo(BuildContext context, DocumentSnapshot documentSnapshot) {
  CollectionReference todos =
      FirebaseFirestore.instance.collection('todoscollection');

  Widget okButton = TextButton(
    child: text("Ok", 15),
    onPressed: () {
      todos.doc(documentSnapshot.id).delete();
      Navigator.pop(context);
    },
  );
  Widget cancleButton = TextButton(
    child: text("Cancel", 15),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  AlertDialog alert = AlertDialog(
    backgroundColor: background,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12.0))),
    title: text("you want delete this todo ?", 20),
    actions: [okButton, cancleButton],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
