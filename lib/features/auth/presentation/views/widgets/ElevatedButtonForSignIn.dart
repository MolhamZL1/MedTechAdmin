import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ElevatedButtonForSignIn extends StatefulWidget {
  const ElevatedButtonForSignIn({super.key});

  @override
  State<ElevatedButtonForSignIn> createState() => _ElevatedButtonForSignIn();
}
class _ElevatedButtonForSignIn extends State<ElevatedButtonForSignIn>{
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: () {},
        child: Text(
          'تسجيل الدخول',
          style: TextStyle(
            fontSize: 18,
            color: Theme.of(context).colorScheme.tertiary,
          ),
        ),
      ),
    );
  }
}
