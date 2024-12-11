import 'package:flutter/material.dart';

class StatusIndicator extends StatelessWidget {
  final String status;

  StatusIndicator({required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 12.0,
      height: 12.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: status == 'Available' ? Colors.green : Colors.red, // Color based on status
      ),
    );
  }
}