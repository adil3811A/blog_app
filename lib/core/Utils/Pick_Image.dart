

import 'dart:io';

import 'package:image_picker/image_picker.dart';

Future<File?> pickImage() async{
  try{
    final path =await ImagePicker().pickImage(source: ImageSource.gallery);
    if(path!=null){
      return  File(path.path);
    }else{
      return null;
    }

  }catch(e){
    return null;
  }
}
