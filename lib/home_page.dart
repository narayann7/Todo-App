// ignore_for_file: prefer_const_constructors
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todoapp/all_constant.dart';
import 'package:todoapp/more_than_ones_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// ignore: use_key_in_widget_constructors
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference todos =
      FirebaseFirestore.instance.collection('todoscollection');
  String str = "";
  bool status = false;
  late int index_id = 0;
  late String id;
  TextEditingController todo = TextEditingController();
  @override
  // ignore: must_call_super
  void initState() {
    setState(() {
      if (str != "") {
        index_id = index_id + 1;
        todos.add({"todo": str, "status": false, "index": index_id});
        todo.text = "";
        str = "";
      }
      if (status == true) {
        todos.doc(id).update({'status': status});
        id = "";
        status = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: background,
        body: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.30,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(color: background),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  text("To Do App", 45),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.035,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.056,
                        width: MediaQuery.of(context).size.width * 0.71,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: TextField(
                            controller: todo,
                            onChanged: (s) {
                              str = s;
                            },
                            style: style,
                            cursorColor: black,
                            decoration: InputDecoration(
                              hintText: "type something here...",
                              hintStyle: GoogleFonts.getFont('Sen',
                                  fontSize: 17, color: Colors.grey[600]),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: const [
                              BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 4.0,
                                  spreadRadius: 1.5,
                                  offset: Offset(1, 5)),
                            ]),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.035,
                      ),
                      GestureDetector(
                        onTap: () {
                          initState();
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.053,
                          width: MediaQuery.of(context).size.width * 0.11,
                          child: Icon(
                            Icons.add,
                            color: background,
                          ),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: black,
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 4.0,
                                    spreadRadius: 1,
                                    offset: Offset(1, 5)),
                              ]),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.70,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(color: background),
              child: StreamBuilder<QuerySnapshot>(
                stream: firestore
                    .collection('todoscollection')
                    .orderBy('index', descending: false)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        physics: const BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics()),
                        itemCount: snapshot.data!.size,
                        itemBuilder: (BuildContext context, int index) {
                          DocumentSnapshot documentSnapshot =
                              snapshot.data!.docs[index];

                          if (snapshot.data!.size == 0) {
                            return Center(
                              child: Text("add todo", style: style),
                            );
                          } else {
                            index_id = max(index_id, documentSnapshot['index']);
                            return Padding(
                              padding: const EdgeInsets.only(
                                  left: 25, right: 25, top: 8.5, bottom: 8.5),
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.075,
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
                                child: Center(
                                  child: ListTile(
                                    leading: Checkbox(
                                      activeColor: black,
                                      value: documentSnapshot['status'],
                                      onChanged: (ch) {
                                        id = documentSnapshot.id;
                                        status =
                                            documentSnapshot['status'] == true
                                                ? false
                                                : true;
                                        initState();
                                      },
                                    ),
                                    title: SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.65,
                                      // color: Colors.amber,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                              child: Text(
                                            documentSnapshot['todo'],
                                            style: GoogleFonts.getFont('Sen',
                                                color: black, fontSize: 20),
                                            maxLines: 1,
                                          )),
                                          Row(
                                            // ignore: prefer_const_literals_to_create_immutables
                                            children: [
                                              GestureDetector(
                                                  onTap: () {
                                                    editToDo(context,
                                                        documentSnapshot);
                                                  },
                                                  child: Image(
                                                    image: AssetImage(
                                                        "images/edit.png"),
                                                    height: 23,
                                                  )),
                                              SizedBox(
                                                width: 15,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  deleteToDo(context,
                                                      documentSnapshot);
                                                },
                                                child: Image(
                                                  image: AssetImage(
                                                      "images/Trash.png"),
                                                  height: 29,
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }
                        });
                  } else {
                    return Center(
                      child: CircularProgressIndicator(
                        color: black,
                      ),
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
