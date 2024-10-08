import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter_slidable/flutter_slidable.dart';

class ChecklistItem extends StatelessWidget {
  const ChecklistItem({
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
      padding: const EdgeInsets.fromLTRB(5, 5, 5, 5).r,
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: deleteFunction,
              icon: Icons.delete,
              backgroundColor: Colors.red,
            ),
          ],
        ),

        //Checkbox Container
        child: Container(
          decoration:  BoxDecoration(
            borderRadius: BorderRadiusDirectional.circular(10.r),
            color: const Color.fromARGB(255, 222, 222, 227),
          ),
          padding: const EdgeInsets.all(4).r,
          child: Row(
            children: [
              

              //Checkbox code
              Checkbox(
                activeColor: Colors.greenAccent,
                side: BorderSide(color: Colors.blue.shade900, width: 3),
                value: gotitem,
                onChanged: onChanged,
              ),

              //Image Code
              Padding(
                padding: const EdgeInsets.only(left: 10).r,
                child: image != null
                    ? image is String
                    ? Image.asset(
                  image,
                  width: 45.r,
                  height: 45.r,
                  fit: BoxFit.cover,
                )
                    : Image.file(
                  File((image as XFile).path),
                  width: 45.r,
                  height: 45.r,
                  fit: BoxFit.cover,
                )
                    : Container(
                  width: 35.r,
                  height: 35.r,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Icon(
                    Icons.help_outline,
                    size: 30.r,
                    color: Colors.white,
                  ),
                ),
              ),

              const SizedBox(width: 10),

              //Checklist item name
              Expanded(
                child: Text(
                  itemname,
                  style: TextStyle(
                    decoration: gotitem
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                    decorationColor: Colors.blue[900],
                    decorationThickness: 2.r,
                    decorationStyle: TextDecorationStyle.solid,
                    color: Colors.black,
                    fontSize: 16.r,
                    fontWeight: FontWeight.w600
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
