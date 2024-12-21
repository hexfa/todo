import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo/core/di/di.dart';
import 'package:todo/core/util/date_time_convert.dart';
import 'package:todo/data/models/due_model.dart';
import 'package:todo/data/models/task_model_response.dart';
import 'package:todo/domain/entities/project.dart';
import 'package:todo/presentation/bloc/create_task/create_task_bloc.dart';
import 'package:todo/presentation/views/base/base-state.dart';
import 'package:todo/presentation/views/state_widget.dart';
import 'package:uuid/uuid.dart';

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
              title: Text(localization.createTask),
            ),
            body: state is CreateTaskLoadingState
                ? StateWidget(isLoading: true, null)
                : Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextField(
                          controller: _titleController,
                          decoration: const InputDecoration(labelText: 'Title'),
                        ),
                        TextField(
                          controller: _descriptionController,
                          decoration:
                              const InputDecoration(labelText: 'Description'),
                        ),
                        // project
                        DropdownButton<Project>(
                            value: _selectProject,
                            hint: Text('Select a project'),
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
                            isExpanded: true),
                        // priority
                        DropdownButton<String>(
                            value: _selectPriority,
                            hint: Text('Select a task state'),
                            items: _priorityList.map((String option) {
                              return DropdownMenuItem<String>(
                                value: option,
                                child: Text('$option'),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                _selectPriority = newValue;
                              });
                            },
                            isExpanded: true),
                        // end date
                        InkWell(
                          onTap: () {
                            _pickDate(context);
                          },
                          child: ListTile(
                            leading: Icon(Icons.arrow_drop_down),
                            title: Text(
                              _selectEndDate == null
                                  ? "Pick a end Date"
                                  : "End Date: ${DateFormat('yyyy-MM-dd').format(_selectEndDate!)}",
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                        Checkbox(
                          value: isRecurring,
                          onChanged: (bool? value) {
                            setState(() {
                              isRecurring = value ?? false;
                            });
                          },
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            getBloc<CreateTaskBloc>(context).add(AddEvent(
                                TaskModelResponse(
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
                          child: const Text('Add Task'),
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
