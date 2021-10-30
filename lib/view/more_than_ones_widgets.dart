// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:todoapp/model/all_constant.dart';

Widget newToDo(BuildContext context, String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.5),
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
        leading: Icon(
          Icons.check_circle_outline,
          color: black,
        ),
        title: SizedBox(
          width: MediaQuery.of(context).size.width * 0.65,
          // color: Colors.amber,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: Text(
                text,
                maxLines: 1,
              )),
              Row(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  Icon(
                    Icons.edit_location_alt_rounded,
                    color: black,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.delete_forever_rounded,
                    color: black,
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

editToDo(BuildContext context) {
  Widget okButton = TextButton(
    child: Text("Ok"),
    onPressed: () {
      Navigator.pop(context);
    },
  );
  Widget cancleButton = TextButton(
    child: Text("Cancel"),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  AlertDialog alert = AlertDialog(
    title: Text("edit ToDo"),
    content: TextField(),
    actions: [okButton, cancleButton],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
