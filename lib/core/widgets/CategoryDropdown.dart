import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class CategoryDropdown extends StatefulWidget {
  final List<String> categories;
  final ValueChanged<String?> onChanged;
  final String selected;

  const CategoryDropdown({
    super.key,
    required this.categories,
    required this.onChanged,
    required this.selected,
  });

  @override
  State<CategoryDropdown> createState() => _CategoryDropdownState();
}

class _CategoryDropdownState extends State<CategoryDropdown> {
  late String _selected;
  bool isOpen = false;

  @override
  void initState() {
    super.initState();
    _selected = widget.selected;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: containerDec(),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selected,
          onTap: () {
            isOpen = !isOpen;
            setState(() {});
          },
          icon: const Icon(Icons.keyboard_arrow_down),
          style: const TextStyle(fontSize: 14, color: Colors.black87),
          items:
              widget.categories.map((category) {
                return DropdownMenuItem<String>(
                  value: category,
                  child: Text(
                    category,
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium!.copyWith(color: Colors.black),
                  ),
                );
              }).toList(),
          onChanged: (value) {
            if (value != null) {
              setState(() {
                _selected = value;
              });
              widget.onChanged(value);
            }
          },
        ),
      ),
    );
  }

  BoxDecoration containerDec() {
    return BoxDecoration(
      border: Border.all(
        color: isOpen ? AppColors.primary : Colors.grey.shade400,
      ),
      borderRadius: BorderRadius.circular(8),
      color: Colors.white,
    );
  }
}
