import 'package:flutter/material.dart';
import '../../../app_colors.dart';

class CustomSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onChanged;
  final String? hintText;

  const CustomSearchBar({
    Key? key,
    required this.controller,
    required this.onChanged,
    this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      style: TextStyle(
        color: AppColors.gold, // Set the text color to gold
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: AppColors.gold,
        ),
        prefixIcon: Icon(Icons.search, color: AppColors.gold),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.brightBlue.withOpacity(0.1),
            width: 2.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.gold,
            width: 2.0,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        filled: true,
        fillColor: AppColors.brightBlue.withOpacity(0.1),
      ),
    );
  }
}
