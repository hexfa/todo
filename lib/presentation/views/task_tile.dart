import 'package:flutter/material.dart';
import 'package:todo/core/util/date_time_convert.dart';
import 'package:todo/domain/entities/task.dart';
import 'package:todo/presentation/route/rout_paths.dart';
import 'package:todo/presentation/views/base/base-stateless-widget.dart';
import 'package:todo/presentation/views/dialog.dart';

class TaskTile extends BaseStatelessWidget {
  final TaskEntity task;
  final VoidCallback onDeleteConfirm;

  const TaskTile(
      {super.key, required this.task, required this.onDeleteConfirm});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        onTap: () {
          router(context).push('${AppRoutePath.updateTaskRoute}/${task.id}');
        },
        title: Text(
          task.content,
          maxLines: 1,
          style: TextStyle(
            color: theme(context).colorScheme.onSurface,
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
        subtitle: task.priority == 3
            ? Text(
                "${localization(context).totalTime} ${DateTimeConvert.formatSecondsToTime((task.duration?.amount ?? 0) * 60)}")
            : null,
        trailing: IconButton(
          onPressed: () {
            showCustomDialog(
                context: context,
                title: localization(context).confirmDeletion,
                content: localization(context).wantConfirmDeletionTask,
                cancelText: localization(context).cancel,
                confirmText: localization(context).delete,
                onConfirm: () {
                  onDeleteConfirm();
                });
          },
          icon: const Icon(
            Icons.delete_outline,
            color: Colors.redAccent,
          ),
        ),
      ),
    );
  }
}
