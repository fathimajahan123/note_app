// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

class Menucard extends StatelessWidget {
  const Menucard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.lightBlue, borderRadius: BorderRadius.circular(10)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Text(
                "data",
                style: TextStyle(fontSize: 20),
              ),
              Spacer(),
              Icon(Icons.edit),
              Icon(Icons.delete)
            ],
          ),
          Text("data"),
          Row(
            children: [Text("data"), Icon(Icons.share)],
          )
        ],
      ),
    );
  }
}
