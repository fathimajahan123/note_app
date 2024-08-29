// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:note_app/dummy_db.dart';
import 'package:note_app/utils/app_session.dart';
import 'package:note_app/utils/colorconstats.dart';
import 'package:note_app/view/note_screen/notescreen_2/notescreen_2.dart';
import 'package:note_app/view/note_screen/widgets/menucard.dart';
import 'package:share_plus/share_plus.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen({super.key});

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  TextEditingController titlecontroller = TextEditingController();
  TextEditingController descriptioncontroller = TextEditingController();
  TextEditingController datecontroller = TextEditingController();

  List notecolors = [
    Colorconstats.c1,
    Colorconstats.c2,
    Colorconstats.c3,
    Colorconstats.c4,
    Colorconstats.c5,
  ];
  final noteBox = Hive.box(AppSession.notebox);
  List notekeys = [];

  int selectedcolorindex = 0;

  @override
  void initState() {
    notekeys = noteBox.keys.toList();
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      floatingActionButton: FloatingActionButton(
          shape: OvalBorder(),
          child: Icon(Icons.add),
          onPressed: () {
            titlecontroller.clear();
            descriptioncontroller.clear();
            datecontroller.clear();

            customBottomsheet(context);
          }),
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: Text("NOTES"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: GridView.builder(
              itemCount: notekeys.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, mainAxisSpacing: 5, crossAxisSpacing: 5),
              itemBuilder: (context, index) {
                final currentnote = noteBox.get(notekeys[index]);
                return Menucard(
                  cardColor: notecolors[currentnote["colorindex"]],
                  title: currentnote["title"],
                  description: currentnote["description"],
                  date: currentnote["date"],
                  //share=================
                  onShare: () {
                    Share.share("""${currentnote["title"]}
                        ${currentnote["description"]}""");
                  },
                  //delete========
                  onDelete: () {
                    noteBox.delete(notekeys[index]);
                    notekeys = noteBox.keys.toList();

                    setState(() {});
                  },
                  //edit===============
                  onEdit: () {
                    selectedcolorindex = currentnote["colorindex"];
                    titlecontroller.text = currentnote["title"];
                    descriptioncontroller.text = currentnote["description"];
                    datecontroller.text = currentnote["date"];

                    customBottomsheet(context, isEdit: true, index: index);
                  },
                );
              }),
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
                  isEdit ? "EDIT NOTE" : "ADD NOTE",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5,
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
                    readOnly: true,
                    controller: datecontroller,
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        hintText: "Date",
                        suffixIcon: IconButton(
                            onPressed: () async {
                              var selectedDate = await showDatePicker(
                                  context: context,
                                  firstDate: DateTime(2020),
                                  lastDate: DateTime.now());
                              print(selectedDate.toString());

                              if (selectedDate != null) {
                                datecontroller.text =
                                    DateFormat().format(selectedDate);
                              }

                              datecontroller.text = selectedDate.toString();
                            },
                            icon: Icon(Icons.calendar_month)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10))),
                SizedBox(
                  height: 5,
                ),
                StatefulBuilder(
                  builder: (context, setState) => Row(
                    children: List.generate(
                        notecolors.length,
                        (index) => Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  onTap: () {
                                    selectedcolorindex = index;
                                    setState(() {});
                                  },
                                  child: Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: selectedcolorindex == index
                                          ? Border.all(
                                              width: 3, color: Colors.black)
                                          : null,
                                      color: notecolors[index],
                                    ),
                                    child: selectedcolorindex == index
                                        ? Icon(Icons.check)
                                        : null,
                                  ),
                                ),
                              ),
                            )),
                  ),
                ),
                SizedBox(
                  height: 5,
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
                          //height: 70,
                          decoration: BoxDecoration(
                              color: Colors.redAccent.shade100,
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: Text(
                                textAlign: TextAlign.center,
                                "CANCEL",
                                style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () async {
                          if (isEdit) {
                            noteBox.put(notekeys[index!], {
                              "title": titlecontroller.text,
                              "description": descriptioncontroller.text,
                              "date": datecontroller.text,
                              "colorindex": selectedcolorindex
                            });
                            // DummyDb.notelist[index!] = {
                            //   "title": titlecontroller.text,
                            //   "description": descriptioncontroller.text,
                            //   "date": datecontroller.text,
                            //   "colorindex": selectedcolorindex
                            // };
                          } else {
                            await noteBox.add({
                              "title": titlecontroller.text,
                              "description": descriptioncontroller.text,
                              "date": datecontroller.text,
                              "colorindex": selectedcolorindex
                            });
                            notekeys = noteBox.keys.toList();

                            // DummyDb.notelist.add({
                            //   "title": titlecontroller.text,
                            //   "description": descriptioncontroller.text,
                            //   "date": datecontroller.text,
                            //   "colorindex": selectedcolorindex
                            // });
                          }
                          Navigator.pop(context);
                          setState(() {});
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.lightGreenAccent.shade100,
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: Text(
                                textAlign: TextAlign.center,
                                isEdit ? "UPDATE" : "SAVE",
                                style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
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
