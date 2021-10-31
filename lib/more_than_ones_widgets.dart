// ignore_for_file: prefer_const_constructors
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todoapp/all_constant.dart';

Widget newToDo(BuildContext context, String todo, bool? check,
    DocumentSnapshot documentSnapshot, Key key) {
  CollectionReference todos = FirebaseFirestore.instance.collection('todos');

  return Padding(
    padding: const EdgeInsets.only(left: 25, right: 25, top: 8.5, bottom: 8.5),
    child: Container(
      height: MediaQuery.of(context).size.height * 0.07,
      width: MediaQuery.of(context).size.width * 0.85,
      decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
                color: Colors.grey,
                blurRadius: 3.0,
                spreadRadius: 1.5,
                offset: Offset(1, 4)),
          ]),
      child: ListTile(
        leading: Container(
          width: 10,
        ),
        title: SizedBox(
          width: MediaQuery.of(context).size.width * 0.65,
          // color: Colors.amber,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: Text(
                todo,
                style: style,
                maxLines: 1,
              )),
              Row(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  GestureDetector(
                      onTap: () {
                        editToDo(context, documentSnapshot);
                      },
                      child: Image(
                        image: AssetImage("images/edit.png"),
                        height: 20,
                      )),
                  SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      deleteToDo(context, documentSnapshot);
                    },
                    child: Image(
                      image: AssetImage("images/Trash.png"),
                      height: 27,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    ),
  );
}

editToDo(BuildContext context, DocumentSnapshot documentSnapshot) {
  CollectionReference todos = FirebaseFirestore.instance.collection('todos');
  String? todo = documentSnapshot['todo'];
  TextEditingController editToDo = TextEditingController(text: todo);
  DateTime time = DateTime.now();

  Widget okButton = TextButton(
    child: text("Ok", 15),
    onPressed: () {
      todos
          .doc(documentSnapshot.id)
          .update({"todo": editToDo.text, "status": false, "time": time});
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
  CollectionReference todos = FirebaseFirestore.instance.collection('todos');

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
