import 'package:flutter/material.dart';

import '../theme.dart';

class TextEditingField extends StatelessWidget {
  @override
  var controller = TextEditingController();
  String? label = '';
  String? Function(String?) validator;
  var keyboardType;
  bool? isPassword;

  TextEditingField({
    required this.controller,
    required this.label,
    required this.validator,
    this.keyboardType = TextInputType.text,
    required this.isPassword,
  });

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, bottom: 20),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: MyTheme.blueColor),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: MyTheme.blueColor),
            borderRadius: BorderRadius.circular(15),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: MyTheme.blueColor),
            borderRadius: BorderRadius.circular(15),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: MyTheme.blueColor),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        validator: validator,
        keyboardType: keyboardType,
        obscureText: isPassword!,
        style: Theme.of(context).textTheme.titleSmall,
      ),
    );
  }
}
