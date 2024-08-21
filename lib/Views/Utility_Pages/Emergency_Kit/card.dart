import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'checklist.dart';

class _PcardState extends State<Pcard> {
  List<List<dynamic>> thelist = [
    ['Water', false, 'assets/images/dashboard/checklist_images/water.jpg'],
    ['Food', false, 'assets/images/dashboard/checklist_images/food.jpg'],
    ['First Aid Kit', false,' assets/images/dashboard/checklist_images/firstaid.jpg'],
    ['Cash', false, 'assets/images/dashboard/checklist_images/money.jpg'],
    ['Prescription medicines', false, 'assets/images/dashboard/checklist_images/medicine.jpg'],
    ['Hygiene Supplies', false, 'assets/images/dashboard/checklist_images/hygiene.jpeg'],
    ['Communication Devices', false, 'assets/images/dashboard/checklist_images/phone.jpg'],
    ['Clothes', false, 'assets/images/dashboard/checklist_images/clothes.jpg'],
    ['Important Documents', false, 'assets/images/dashboard/checklist_images/documents.jpg'],

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
          backgroundColor: Colors.white,
          title: Text('Add New Item',
            style: TextStyle
              (
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.blue[900],

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
                      decoration: InputDecoration(hintText: 'Enter Item',
                          border:  OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.blue.shade900,
                              width: 2.0,
                            ),
                          ),
                          contentPadding: const EdgeInsets.fromLTRB(10, 0, 10, 0)
                      ),
                    ),
                  ),

                  const SizedBox(height: 10,width: 10),

                  ElevatedButton(
                    onPressed: imageSelect,
                    child: Icon(Icons.image,color: Colors.blue[900],),
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
                  style: TextStyle( fontSize: 20,color: Colors.blue[900],
                    fontWeight: FontWeight.bold,)),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel',
                style: TextStyle(  fontSize: 20,color: Colors.blue[900],
                  fontWeight: FontWeight.bold,),
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
      appBar: AppBar
        (
        title: Padding(
          padding: const EdgeInsets.fromLTRB(30, 10, 0, 0),
          child: Text('CommuniHelp',
            style: TextStyle
              (
              color: Colors.blue[900],
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
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
