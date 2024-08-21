import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import 'checklist.dart';

class _PcardState extends State<Pcard> {
  List<List<dynamic>> thelist = [
    ['Bottled Water', false, 'assets/images/dashboard/checklist_images/water.jpg'],
    ['Canned Food', false, 'assets/images/dashboard/checklist_images/food.jpg'],
    ['First Aid Kit', false, 'assets/images/dashboard/checklist_images/firstaid.jpg'],
    ['Cash', false, 'assets/images/dashboard/checklist_images/money.jpg'],
    ['Prescription medicines', false, 'assets/images/dashboard/checklist_images/medicine.jpg'],
    ['Hygiene kit', false, 'assets/images/dashboard/checklist_images/hygiene.jpeg'],
    ['Radyo de baterya', false, 'assets/images/dashboard/checklist_images/phone.jpg'],
    ['Extra Clothes', false, 'assets/images/dashboard/checklist_images/clothes.jpg'],
    ['Mga importanteng documento (national id, passport, birth certificate)', false, 'assets/images/dashboard/checklist_images/documents.jpg'],

  ];
  XFile? image;



  void checkBoxChanged(int index)
  {
    setState(() {thelist[index][1] = !thelist[index][1];});
  }

  Future<void> imageSelect() async
  {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedImage = await picker.pickImage(source: ImageSource.gallery);
    setState(() {image = pickedImage;});
  }

  void _addItem(String itemName) {
    setState(() {
      thelist.add([itemName, false, image]);
    });
    Navigator.of(context).pop();
  }

  void addItemBox() {
    final TextEditingController textController = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder
            (
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: const Color(0xFFF5F5F5),
          title: Text('Add New Item',
            style: TextStyle
              (
              fontSize: 20.r,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF3D424A),

            ),
          ),
          content: Column
            (
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: textController,
                      decoration: InputDecoration(
                        hintText: 'Enter checklist',
                        hintStyle: const TextStyle(
                          color: Color(0xFF3D424A)
                        ),
                          border:  OutlineInputBorder(
                            borderSide: BorderSide(
                              color: const Color(0xFF3D424A),
                              width: 2.0.r,
                            ),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(width: 1.r, color: const Color(0xFF3D424A))
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(width: 3.r, color: const Color(0xFF3D424A))
                          ),
                          contentPadding: const EdgeInsets.fromLTRB(10, 0, 10, 0).r
                      ),
                    ),
                  ),

                  SizedBox(height: 10.r,width: 10.r),

                  MaterialButton(
                    color: const Color(0xFF3D424A),
                    onPressed: imageSelect,
                    child: const Icon(
                      Icons.image,
                      color: Color(0xFFF5F5F5),
                    ),
                  ),
                ],
              ),
              image != null ? Image.file(File(image!.path)) : Container(),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => _addItem(textController.text),
              child: Text('Add',
                  style: TextStyle(
                    fontSize: 20.r,
                    color: Colors.blue[900] ,
                    fontWeight: FontWeight.bold,
                )
              ),
            ),

            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel',
                style: TextStyle(
                  fontSize: 20.r,
                  color: const Color(0xFF3D424A),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void deleteitem(int index)
  {
    setState(() {
      thelist.removeAt(index);
    }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.lightBlue[100],
        ),
        margin: const EdgeInsets.all(16.0),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text
              (
              'Emergency Kit Checklist', style: TextStyle
              (
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder
                (
                itemCount: thelist.length,
                itemBuilder: (BuildContext context, index)
                {
                  return Itemlist
                    (
                    itemname: thelist[index][0],
                    gotitem: thelist[index][1],
                    onChanged: (value) => checkBoxChanged(index),
                    image: thelist[index].length > 2 ? thelist[index][2] : null,
                    deleteFunction: (context) => deleteitem(index),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton
        (
        backgroundColor:(Colors.orange).withOpacity(0.6),
        onPressed: addItemBox,
        elevation: 0,
        child: Icon(Icons.add,size: 40,color: Colors.white.withOpacity(0.5),weight:1000,),

      ),
    );
  }
}

class Pcard extends StatefulWidget {
  const Pcard({super.key});

  @override
  State<Pcard> createState() => _PcardState();
}
