import 'package:flutter/material.dart';


class BlogEditing extends StatelessWidget {

  final TextEditingController controller;
  final String hintText;

  const BlogEditing({super.key, required this.controller, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
      ),
      maxLines: null,
      validator: (value) {
        if(value!.trim().isEmpty){
          return "$hintText is no empty";
        }
        return null;
      },
    );
  }
}
