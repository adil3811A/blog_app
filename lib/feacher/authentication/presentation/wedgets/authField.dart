import 'package:flutter/material.dart';

class Authfield extends StatelessWidget {
  final TextEditingController conroller;
  final String hint;
  final bool isObscureText;
  const Authfield({super.key,  required this.hint, required this.conroller, this.isObscureText= false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isObscureText,
      controller: conroller,
      decoration: InputDecoration(
        hintText: hint,
      ),
      validator: (value) {
        if(value!.isEmpty){
          return "$hint is missing";
        }
        return null;
      },
    );
  }
}
