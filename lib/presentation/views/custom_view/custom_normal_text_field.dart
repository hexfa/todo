import 'package:flutter/material.dart';
import 'package:todo/presentation/views/base/base-stateless-widget.dart';

class CustomNormalTextField extends BaseStatelessWidget {
  final TextEditingController? controller;
  final String labelText;

  const CustomNormalTextField(
      {super.key, required this.controller, required this.labelText});

  @override
  Widget build(BuildContext context) {
    double borderRadius = 12;
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius)),
        labelText: labelText,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide:
              BorderSide(color: theme(context).colorScheme.primary, width: 2.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: const BorderSide(color: Colors.grey, width: 1.0),
        ),
      ),
    );
  }
}
