import 'package:flutter/material.dart';
import '../../core/app_colors.dart';

class CustomSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onChanged;

  CustomSearchBar({required this.controller, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: 'Search friends...',
          hintStyle: TextStyle(
            color: AppColors.gold,
          ),
          prefixIcon: Icon(Icons.search, color: AppColors.gold),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.brightBlue.withOpacity(0.1), width: 2.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.gold, width: 2.0),
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
