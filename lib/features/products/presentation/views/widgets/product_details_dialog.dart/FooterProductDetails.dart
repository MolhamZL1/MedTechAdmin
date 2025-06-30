import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'
    show FontAwesomeIcons;

class FooterProductDetails extends StatelessWidget {
  const FooterProductDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ElevatedButton.icon(
            icon: Icon(FontAwesomeIcons.edit, size: 14),
            onPressed: () {},
            label: Text("Edit Product"),
          ),
        ],
      ),
    );
  }
}
