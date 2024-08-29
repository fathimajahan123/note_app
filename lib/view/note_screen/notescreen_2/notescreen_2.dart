// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

class Notescreen2 extends StatelessWidget {
  const Notescreen2({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "title",
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              decorationThickness: 3,
                              decorationStyle: TextDecorationStyle.solid,
                              decorationColor: Colors.blue,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 30),
                        ),
                        Spacer(),
                        Icon(Icons.share)
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "description",
                      style: TextStyle(fontSize: 20),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [Text("date")],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
