import 'package:flutter/material.dart';
import 'package:todo/presentation/views/base/base-stateless-widget.dart';

class CustomMultiLineTextField extends BaseStatelessWidget {
  final TextEditingController? controller;
  final String labelText;
  final int countLine;

  const CustomMultiLineTextField(
      {super.key,
      required this.controller,
      required this.labelText,
      required this.countLine});

  @override
  Widget build(BuildContext context) {
    double borderRadius = 12;
    return TextField(
      controller: controller,
      maxLines: countLine,
      minLines: countLine,
      keyboardType: TextInputType.multiline,
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius)),
        labelText: labelText,
        alignLabelWithHint: true,
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
      style: theme(context).textTheme.bodyMedium,
      scrollPadding: const EdgeInsets.all(20),
      scrollPhysics: const BouncingScrollPhysics(),
    );
  }
}
