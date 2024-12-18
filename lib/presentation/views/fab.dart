import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/presentation/bloc/project_bloc.dart';
import 'package:todo/presentation/bloc/project_event.dart';
import 'package:todo/presentation/views/base/base-state.dart';

class FAB extends StatefulWidget {
  FAB({Key? key}) : super(key: key);

  @override
  State<FAB> createState() => _FABState();
}

class _FABState extends BaseState<FAB> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext buildContext) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: buildContext,
          builder: (BuildContext dialogContext) {
            return AlertDialog(
              title:  Text(localization?.createProject??''),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        labelText: 'Project Name',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton.icon(
                      onPressed: () {
                        final name = _controller.text.trim();
                        if (name.isNotEmpty) {
                          context
                              .read<ProjectsBloc>()
                              .add(CreateProjectEvent(name));
                          _controller.clear();
                          Navigator.of(dialogContext).pop();
                        } else {
                          ScaffoldMessenger.of(dialogContext).showSnackBar(
                             SnackBar(
                                content: Text(localization?.pleaseEnterProjectName??'')),
                          );
                        }
                      },
                      icon: const Icon(Icons.add),
                      label:  Text(localization?.createProject??''),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
      child: Material(
        borderRadius: BorderRadius.circular(35), // Increased border radius
        elevation: 8,
        color: theme.colorScheme.primary,
        child: Container(
          width: 56, // Reduced size
          height: 56, // Reduced size
          decoration: BoxDecoration(
            color:theme.colorScheme.primary,
            borderRadius: BorderRadius.circular(35), // Match with Material
          ),
          child:  Center(
            child: Icon(
              Icons.add,
              color: theme.colorScheme.onPrimary,
            ),
          ),
        ),
      ),
    );
  }
}
