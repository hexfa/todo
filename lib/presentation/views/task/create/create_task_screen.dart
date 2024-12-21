import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/core/di/di.dart';
import 'package:todo/core/util/date_time_convert.dart';
import 'package:todo/data/models/due_model.dart';
import 'package:todo/domain/entities/project.dart';
import 'package:todo/domain/entities/task.dart';
import 'package:todo/presentation/bloc/create_task/create_task_bloc.dart';
import 'package:todo/presentation/views/base/base-state.dart';
import 'package:todo/presentation/views/state_widget.dart';

class CreateTaskScreen extends StatefulWidget {
  const CreateTaskScreen({super.key});

  @override
  State<StatefulWidget> createState() => _AddTaskScreen();
}

class _AddTaskScreen extends BaseState<CreateTaskScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  DateTime? _selectEndDate;
  List<Project> _projectList = [];
  Project? _selectProject;
  final List<String> _priorityList = ['todo', 'inProgress', 'done'];
  String? _selectPriority;
  bool isRecurring = false;

  @override
  Widget build(BuildContext context) {
    double borderRadius = 12;
    return BlocProvider(
      create: (_) => getIt<CreateTaskBloc>()..add(InitialDataEvent()),
      child: BlocConsumer<CreateTaskBloc, CreateTaskState>(
        listener: (context, state) {
          if (state is AddSuccessState) {
            navigator.pop();
          }
        },
        builder: (context, state) {
          if (state is InitialDataState) {
            _projectList = state.projectList;
          }

          return Scaffold(
            appBar: AppBar(
              title: Text(
                localization.createTask,
                style: theme.textTheme.titleMedium
                    ?.copyWith(color: theme.colorScheme.onPrimary),
              ),
            ),
            body: state is CreateTaskLoadingState
                ? StateWidget(isLoading: true, null)
                : Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextField(
                          controller: _titleController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(borderRadius)),
                            labelText: localization.content,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(borderRadius),
                              borderSide: BorderSide(
                                  color: theme.colorScheme.primary, width: 2.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(borderRadius),
                              borderSide: const BorderSide(
                                  color: Colors.grey, width: 1.0),
                            ),
                          ),
                        ),
                        TextField(
                          controller: _descriptionController,
                          maxLines: 3,
                          minLines: 3,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(borderRadius)),
                            labelText: localization.description,
                            alignLabelWithHint: true,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(borderRadius),
                              borderSide: BorderSide(
                                  color: theme.colorScheme.primary, width: 2.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(borderRadius),
                              borderSide: const BorderSide(
                                  color: Colors.grey, width: 1.0),
                            ),
                          ),
                          style: theme.textTheme.bodyMedium,
                          scrollPadding: const EdgeInsets.all(20),
                          scrollPhysics: const BouncingScrollPhysics(),
                        ),
                        // project
                        DropdownButtonFormField<Project>(
                          value: _selectProject,
                          hint: Text(localization.selectAProject),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(borderRadius)),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(borderRadius),
                              borderSide: BorderSide(
                                  color: theme.colorScheme.primary, width: 2.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(borderRadius),
                              borderSide: const BorderSide(
                                  color: Colors.grey, width: 1.0),
                            ),
                            filled: false,
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 8.0),
                          ),
                          items: _projectList.map((Project option) {
                            return DropdownMenuItem<Project>(
                              value: option,
                              child: Text(option.name),
                            );
                          }).toList(),
                          onChanged: (Project? newValue) {
                            setState(() {
                              _selectProject = newValue;
                            });
                          },
                          isExpanded: true,
                        ),
                        // priority
                        DropdownButtonFormField<String>(
                          value: _selectPriority,
                          hint: Text(localization.selectATaskState),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(borderRadius)),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(borderRadius),
                              borderSide: BorderSide(
                                  color: theme.colorScheme.primary, width: 2.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(borderRadius),
                              borderSide: const BorderSide(
                                  color: Colors.grey, width: 1.0),
                            ),
                            filled: false,
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 8.0),
                          ),
                          items: _priorityList.map((String option) {
                            return DropdownMenuItem<String>(
                              value: option,
                              child: Text(option),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectPriority = newValue;
                            });
                          },
                          isExpanded: true,
                        ),
                        // end date
                        InkWell(
                            onTap: () {
                              _pickDate(context);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 1.0,
                                ),
                                borderRadius:
                                    BorderRadius.circular(borderRadius),
                              ),
                              child: ListTile(
                                leading: const Icon(Icons.arrow_drop_down),
                                title: Text(
                                  _selectEndDate == null
                                      ? localization.endDateLabel
                                      : "${localization.endDate}: ${DateTimeConvert.convertDateToString(_selectEndDate!)}",
                                  style: theme.textTheme.bodyMedium,
                                ),
                              ),
                            )),
                        Row(
                          children: [
                            Checkbox(
                              value: isRecurring,
                              onChanged: (bool? value) {
                                setState(() {
                                  isRecurring = value ?? false;
                                });
                              },
                              activeColor: isRecurring
                                  ? theme.colorScheme.primary
                                  : Colors.grey,
                            ),
                            Text(localization.isRecurring,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                    color: isRecurring
                                        ? theme.colorScheme.primary
                                        : theme.colorScheme.onSurface)),
                          ],
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            getBloc<CreateTaskBloc>(context).add(AddEvent(
                                TaskEntity(
                                    due: DueModel(
                                        date:
                                            DateTimeConvert.convertDateToString(
                                                _selectEndDate!),
                                        datetime: '',
                                        string: '',
                                        timezone: '',
                                        isRrecurring: isRecurring),
                                    commentCount: 0,
                                    isCompleted: _selectPriority == 'done'
                                        ? true
                                        : false,
                                    creatorId: '',
                                    createdAt: DateTimeConvert.getCurrentDate(),
                                    id: '',
                                    content: _titleController.text,
                                    description: _descriptionController.text,
                                    priority: getSelectPriority(),
                                    projectId: _selectProject != null
                                        ? _selectProject!.id
                                        : '',
                                    labels: [],
                                    order: 0,
                                    url: '')));
                          },
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                            child: Text(localization.createTask,
                                style: theme.textTheme.bodyLarge?.copyWith(
                                    color: theme.colorScheme.onPrimary)),
                          ),
                        ),
                      ],
                    ),
                  ),
          );
        },
      ),
    );
  }

  Future<void> _pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _selectEndDate = picked;
      });
    }
  }

  int getSelectPriority() {
    switch (_selectPriority) {
      case 'inProgress':
        return 2;
      case 'done':
        return 3;
      default:
        return 1;
    }
  }
}
