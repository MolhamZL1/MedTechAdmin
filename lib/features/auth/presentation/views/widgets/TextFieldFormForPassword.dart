import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextFieldFormForPassword extends StatefulWidget {
  const TextFieldFormForPassword({super.key});

  @override
  State<TextFieldFormForPassword> createState() => _TextFieldFormForPassword();

}
class _TextFieldFormForPassword extends State<TextFieldFormForPassword>{
  bool _obscureText = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
  @override
  Widget build(BuildContext context) {
    return  TextFormField(
      obscureText: _obscureText,
      decoration: InputDecoration(
        labelText: 'كلمة المرور',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        suffixIcon: IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility_off : Icons.visibility,
            color: Theme.of(context).colorScheme.primary,
          ),
          onPressed: _togglePasswordVisibility,
        ),
      ),
    );
  }
}
