import 'package:flutter/material.dart';

class AppDropDown extends StatelessWidget {
  final String hintText;
  final List<String> items;
  final String selectedValue;
  final Function(String) onChanged;

  const AppDropDown({
    super.key,
    required this.hintText,
    required this.items,
    required this.selectedValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    // If the selected value is not in the items list, assign an empty string or a default value.
    String displayValue = items.contains(selectedValue) ? selectedValue : '';

    return DropdownButtonFormField<String>(
      value: displayValue.isNotEmpty ? displayValue : null,
      decoration: InputDecoration(
        labelText: hintText,
        labelStyle: TextStyle(color: Colors.black),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
        ),
      ),
      items: items.map((item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item),
        );
      }).toList(),
      onChanged: (value) {
        if (value != null) onChanged(value);
      },
    );
  }
}
