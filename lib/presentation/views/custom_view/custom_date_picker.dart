import 'package:flutter/material.dart';
import 'package:todo/core/util/date_time_convert.dart';
import 'package:todo/presentation/views/base/base-stateless-widget.dart';

class CustomDatePicker extends BaseStatelessWidget {
  final String selectLabel;
  final String unselectLabel;
  final DateTime? selectedDate;
  final void Function(DateTime) onDatePicked;

  const CustomDatePicker({
    super.key,
    required this.selectLabel,
    required this.unselectLabel,
    required this.selectedDate,
    required this.onDatePicked,
  });

  Future<void> _pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      onDatePicked(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _pickDate(context),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: ListTile(
          leading: const Icon(Icons.arrow_drop_down),
          title: Text(
            selectedDate == null
                ? unselectLabel
                : "$selectLabel at ${DateTimeConvert.convertDateToString(selectedDate!)}",
            style: theme(context).textTheme.bodyMedium,
          ),
        ),
      ),
    );
  }
}
