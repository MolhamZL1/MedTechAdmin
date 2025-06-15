import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextFieldFormForEmail extends StatefulWidget {
  const TextFieldFormForEmail({super.key});

  @override
  State<TextFieldFormForEmail> createState() => _TextFieldFormForEmail();
}
class _TextFieldFormForEmail extends State<TextFieldFormForEmail>{
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'البريد الإلكتروني',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
