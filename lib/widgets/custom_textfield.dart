import 'package:flutter/material.dart';

import '../constants/constants.dart';

class CustomTextField extends StatelessWidget {
  String? Function(String?)? validator;
  bool? readOnly = false;
  CustomTextField({
    this.validator,
    this.readOnly = false,
    Key? key,
    required this.chapterNameController,
  }) : super(key: key);

  final TextEditingController chapterNameController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      readOnly: readOnly!,
      controller: chapterNameController,
      keyboardType: TextInputType.name,
      cursorColor: kAppColor,
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        border: InputBorder.none,
        fillColor: kTextFieldColor,
        filled: true,
      ),
    );
  }
}
