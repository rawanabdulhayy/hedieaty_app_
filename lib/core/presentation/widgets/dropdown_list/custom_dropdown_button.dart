// import 'package:flutter/material.dart';
//
// class CustomDropdownButton extends StatelessWidget {
//   final String? value;
//   final List<String> items;
//   final ValueChanged<String?> onChanged;
//   final Widget hint;
//   final Color iconColor;
//   final Color dropdownColor;
//
//   const CustomDropdownButton({
//     Key? key,
//     required this.items,
//     required this.onChanged,
//     this.value,
//     required this.hint,
//     this.iconColor = Colors.black,
//     this.dropdownColor = Colors.white,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return DropdownButton<String>(
//       isExpanded: true,
//       value: value,
//       items: items.map((String item) {
//         return DropdownMenuItem<String>(
//           value: item,
//           child: Text(item),
//         );
//       }).toList(),
//       onChanged: onChanged,
//       hint: hint,
//       icon: Icon(Icons.arrow_drop_down, color: iconColor), // Custom arrow color
//       dropdownColor: dropdownColor,
//     );
//   }
// }
import 'package:flutter/material.dart';

class CustomDropdownButton extends StatelessWidget {
  final String? value;
  final List<String> items;
  final ValueChanged<String?> onChanged;
  final Widget hint;
  final Color iconColor;
  final Color dropdownColor;
  final TextStyle selectedTextStyle;

  const CustomDropdownButton({
    Key? key,
    required this.items,
    required this.onChanged,
    this.value,
    required this.hint,
    this.iconColor = Colors.black,
    this.dropdownColor = Colors.white,
    this.selectedTextStyle = const TextStyle(color: Colors.black), // Default black
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      isExpanded: true,
      value: value,
      items: items.map((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item),
        );
      }).toList(),
      onChanged: onChanged,
      hint: hint,
      icon: Icon(Icons.arrow_drop_down, color: iconColor), // Custom arrow color
      dropdownColor: dropdownColor,
      selectedItemBuilder: (BuildContext context) {
        return items.map((String item) {
          return Align(
            alignment: Alignment.centerLeft, // Align the text properly
            child: Text(
              item,
              style: selectedTextStyle, // Apply custom style for selected item
            ),
          );
        }).toList();
      },
    );
  }
}
