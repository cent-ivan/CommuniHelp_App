import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter_slidable/flutter_slidable.dart';
class Itemlist extends StatelessWidget {
  const Itemlist({
    super.key,
    required this.itemname,
    required this.gotitem,
    required this.onChanged,
    this.image,
    this.deleteFunction,
  });

  final String itemname;
  final bool gotitem;
  final Function(bool?)? onChanged;
  final dynamic image;
  final Function(BuildContext)? deleteFunction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
      child: Slidable(
        endActionPane: ActionPane(
          motion: StretchMotion(),
          children: [
            SlidableAction(
              onPressed: deleteFunction,
              icon: Icons.delete,
              backgroundColor: Colors.red,
              borderRadius: BorderRadius.circular(20),
            ),
          ],
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          padding: EdgeInsets.all(3),
          child: Row(
            children: [
              Checkbox(
                activeColor: Colors.blue[900],
                side: BorderSide(color: Colors.blue.shade900),
                value: gotitem,
                onChanged: onChanged,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: image != null
                    ? image is String
                    ? Image.asset(
                  image,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                )
                    : Image.file(
                  File((image as XFile).path),
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                )
                    : Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Icon(
                    Icons.help_outline,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  itemname,
                  style: TextStyle(
                    decoration: gotitem
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                    decorationColor: Colors.blue[900],
                    decorationThickness: 2,
                    decorationStyle: TextDecorationStyle.solid,
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
