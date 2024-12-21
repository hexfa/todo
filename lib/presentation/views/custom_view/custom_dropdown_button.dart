import 'package:flutter/material.dart';

class CustomDropdown<T> extends StatefulWidget {
  final T? selectedValue;
  final List<T> items;
  final String hintText;
  final Widget Function(T)? itemBuilder;

  const CustomDropdown({
    required this.selectedValue,
    required this.items,
    required this.hintText,
    this.itemBuilder,
    super.key,
  });

  @override
  _CustomDropdownState<T> createState() => _CustomDropdownState<T>();
}

class _CustomDropdownState<T> extends State<CustomDropdown<T>> {
  late T? _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.selectedValue;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      value: _selectedValue,
      hint: Text(widget.hintText),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary, width: 2.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(color: Colors.grey, width: 1.0),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      ),
      items: widget.items.map((T option) {
        return DropdownMenuItem<T>(
          value: option,
          child: widget.itemBuilder != null
              ? widget.itemBuilder!(option)
              : Text(option.toString()),
        );
      }).toList(),
      onChanged: (T? newValue) {
        setState(() {
          _selectedValue = newValue;
        });
      },
      isExpanded: true,
    );
  }
}
