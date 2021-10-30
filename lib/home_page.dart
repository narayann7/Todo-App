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
  CollectionReference todos = FirebaseFirestore.instance.collection('todos');
  String str = "";
  DateTime time = DateTime.now();

  TextEditingController todo = TextEditingController();
  @override
  // ignore: must_call_super
  void initState() {
    setState(() {
      print(time);
      todos
          .add({"todo": str, "status": false, "time": time})
          .then((value) => print("note Added"))
          .catchError((error) => print("Failed"));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                GestureDetector(
                  onTap: () {
                    editToDo(context);
                  },
                  child: Text(
                    "To Do App",
                    style: GoogleFonts.getFont('Sen',
                        fontSize: 45, color: Colors.black),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.035,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.053,
                      width: MediaQuery.of(context).size.width * 0.70,
                      child: TextField(
                        controller: todo,
                        onChanged: (s) {
                          str = s;
                        },

                        cursorColor: black,
                        // ignore: prefer_const_constructors
                        decoration: InputDecoration(
                          border: InputBorder.none,
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
              stream: firestore.collection('todos').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      itemCount: snapshot.data!.size,
                      itemBuilder: (BuildContext context, int index) {
                        DocumentSnapshot ds = snapshot.data!.docs[index];
                        Key k = Key(index.toString());
                        bool check = true;
                        return Stack(
                          children: [
                            newToDo(context, ds['todo'], true, k),
                          ],
                        );
                      });
                } else {
                  return Center(
                      child: Text(
                    "add todo",
                    style: GoogleFonts.getFont('Sen', color: black),
                  ));
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
