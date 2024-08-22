// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

class Menucard extends StatelessWidget {
  const Menucard({
    super.key,
    required this.title,
    required this.description,
    required this.date,
    this.onDelete,
    this.onEdit,
    this.onShare,
  });

  final String title;
  final String description;
  final String date;
  final void Function()? onDelete;
  final void Function()? onEdit;
  final void Function()? onShare;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.lightBlue, borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              Spacer(),
              IconButton(
                onPressed: onEdit,
                icon: Icon(Icons.edit),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            description,
            maxLines: 4,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(date),
              SizedBox(
                width: 10,
              ),
              IconButton(
                onPressed: onShare,
                icon: Icon(Icons.share),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: onDelete,
                icon: Icon(Icons.delete),
              ),
            ],
          )
        ],
      ),
    );
  }
}
