

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showSnackbar(BuildContext context , String content){
  ScaffoldMessenger.of(context)..hideCurrentMaterialBanner()..showSnackBar(SnackBar(content: Text(content)));
}