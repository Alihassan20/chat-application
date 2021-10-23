import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
class UserImagePicker extends StatefulWidget {
  final void Function(File pickedImage ) pickFn;
   const UserImagePicker(this.pickFn, {Key? key}) : super(key: key);
  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {

    File? _pickedImage;
 final ImagePicker  _piker=ImagePicker();
   Future  _getImage(ImageSource src)async{
   final  _pickedImageFile = await _piker.pickImage(source: src,imageQuality: 50,maxWidth: 150);
   if(_pickedImageFile!=null){
     setState(() {
       _pickedImage=File(_pickedImageFile.path);
     });
     widget.pickFn(_pickedImage!);
   }else{
     print ("");
   }

 }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius:40,
          backgroundColor: Colors.grey,
          backgroundImage:_pickedImage != null ?
          FileImage(_pickedImage!):null,
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            FlatButton.icon(onPressed:()=> _getImage(ImageSource.gallery),
                icon: const Icon(Icons.image),
                label:const  Text("Add Image\n from gallery",textAlign: TextAlign.center,)),
            FlatButton.icon(onPressed:()=> _getImage(ImageSource.camera),
                icon: const Icon(Icons.add_photo_alternate_outlined),
                label:const  Text("Add Image\n from Camera",textAlign: TextAlign.center,)),
          ],
        )
      ],

    );
  }
}
