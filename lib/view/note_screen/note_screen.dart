// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:note_app/dummy_db.dart';
import 'package:note_app/view/note_screen/widgets/menucard.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen({super.key});

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  TextEditingController titlecontroller = TextEditingController();
  TextEditingController descriptioncontroller = TextEditingController();
  TextEditingController datecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 80, 123, 143),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            titlecontroller.clear();
            descriptioncontroller.clear();
            datecontroller.clear();

            customBottomsheet(context);
          }),
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        centerTitle: true,
        title: Text("NOTES"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: GridView.builder(
            itemCount: DummyDb.notelist.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, mainAxisSpacing: 5, crossAxisSpacing: 5),
            itemBuilder: (context, index) => Menucard(
              title: DummyDb.notelist[index]["title"],
              description: DummyDb.notelist[index]["description"],
              date: DummyDb.notelist[index]["date"],
              onDelete: () {
                DummyDb.notelist.removeAt(index);
                setState(() {});
              },
              onEdit: () {
                titlecontroller.text = DummyDb.notelist[index]["title"];
                descriptioncontroller.text =
                    DummyDb.notelist[index]["description"];
                datecontroller.text = DummyDb.notelist[index]["date"];

                customBottomsheet(context, isEdit: true, index: index);
              },
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> customBottomsheet(BuildContext context,
      {bool isEdit = false, int? index}) {
    return showModalBottomSheet(
      backgroundColor: Colors.blue,
      isScrollControlled: true,
      context: context,
      builder: (context) => Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: SizedBox(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  isEdit ? "edit note" : "add note",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
                TextField(
                  controller: titlecontroller,
                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: "Title",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10)),
                ),
                SizedBox(
                  height: 5,
                ),
                TextField(
                    controller: descriptioncontroller,
                    maxLines: 4,
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        hintText: "Description",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10))),
                SizedBox(
                  height: 5,
                ),
                TextField(
                    controller: datecontroller,
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        hintText: "Date",
                        suffixIcon: Icon(Icons.calendar_month),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10))),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 70,
                          color: Colors.lightBlueAccent,
                          child: Text(
                            textAlign: TextAlign.center,
                            "cancel",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          if (isEdit) {
                            DummyDb.notelist[index!] = {
                              "title": titlecontroller.text,
                              "description": descriptioncontroller.text,
                              "date": datecontroller.text
                            };
                          } else {
                            DummyDb.notelist.add({
                              "title": titlecontroller.text,
                              "description": descriptioncontroller.text,
                              "date": datecontroller.text
                            });
                          }
                          Navigator.pop(context);
                          setState(() {});
                        },
                        child: Container(
                          height: 70,
                          color: Colors.lightBlueAccent,
                          child: Text(
                            textAlign: TextAlign.center,
                            isEdit ? "update" : "save",
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
