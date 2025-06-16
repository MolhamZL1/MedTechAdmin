import 'package:flutter/material.dart';

import '../../../../../core/functions/custom_validator.dart';

class CustomPasswordTextField extends StatefulWidget {
  const CustomPasswordTextField({
    super.key,
    required this.onSaved,
    required this.autovalidateMode,
  });
  final void Function(String?) onSaved;
  final AutovalidateMode autovalidateMode;

  @override
  State<CustomPasswordTextField> createState() =>
      _CustomPasswordTextFieldState();
}

class _CustomPasswordTextFieldState extends State<CustomPasswordTextField> {
  bool isobsecureText = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onSaved: widget.onSaved,
      obscureText: isobsecureText,
      autovalidateMode: widget.autovalidateMode,
      validator: CustomValidator.passwordValidator,
      decoration: InputDecoration(
        labelText: "Password",
        suffixIcon: IconButton(
          onPressed: () {
            isobsecureText = !isobsecureText;
            setState(() {});
          },
          icon: Icon(
            isobsecureText
                ? Icons.visibility_off_outlined
                : Icons.visibility_outlined,
          ),
        ),
      ),
    );
  }
}
