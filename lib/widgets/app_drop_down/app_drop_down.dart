import 'package:flutter/material.dart';
import 'package:luggage_tracking/const/app_colors.dart';

class AppDropDown<T> extends StatefulWidget {
  final String? hintText;
  final List<T> items;
  final T? value;
  final ValueChanged<T?>? onChanged;

  const AppDropDown({
    super.key,
    required this.items,
    this.hintText,
    this.value,
    this.onChanged,
  });

  @override
  State<AppDropDown<T>> createState() => _AppDropDownState<T>();
}

class _AppDropDownState<T> extends State<AppDropDown<T>> with SingleTickerProviderStateMixin {
  late AnimationController _rotationController;
  bool _isExpanded = false;
  T? selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.value;
    _rotationController = AnimationController(
      duration: Duration(milliseconds: 200),
      vsync: this,
      upperBound: 0.5, // 180 degrees
    );
  }

  void toggleRotation(bool expanded) {
    if (expanded) {
      _rotationController.forward();
    } else {
      _rotationController.reverse();
    }
    setState(() {
      _isExpanded = expanded;
    });
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      value: selectedValue,
      items: widget.items.map((item) {
        return DropdownMenuItem<T>(
          value: item,
          child: Text(item.toString(), style: TextStyle(color: AppColors.instance.black400)),
        );
      }).toList(),
      onChanged: (value) {
        setState(() => selectedValue = value);
        if (widget.onChanged != null) {
          widget.onChanged!(value);
        }
      },
      onTap: () => toggleRotation(!_isExpanded),
      decoration: InputDecoration(
        labelText: widget.hintText,
        labelStyle: TextStyle(color: AppColors.instance.black400),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.instance.white600),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.instance.white600),
        ),
      ),
      icon: RotationTransition(
        turns: _rotationController,
        child: Icon(Icons.expand_more, color: AppColors.instance.black400),
      ),
      dropdownColor: Colors.white,
      style: TextStyle(color: AppColors.instance.black400),
    );
  }
}
