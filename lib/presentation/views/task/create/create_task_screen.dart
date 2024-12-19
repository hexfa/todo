import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo/domain/entities/project.dart';
import 'package:todo/domain/entities/task.dart';
import 'package:todo/presentation/bloc/create_task/create_task_bloc.dart';
import 'package:todo/presentation/views/base/base-state.dart';
import 'package:uuid/uuid.dart';

class CreateTaskScreen extends StatefulWidget {
  const CreateTaskScreen({super.key});

  @override
  State<StatefulWidget> createState() => _AddTaskScreen();
}

class _AddTaskScreen extends BaseState<CreateTaskScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  DateTime? _selectStartDate;
  DateTime? _selectEndDate;

  List<String> _stateList = [];
  String? _selectState;

  List<Project> _projectList = [];
  Project? _selectProject;

  List<String> _pointList = [];
  String? _selectPoint;

  List<int> _priorityList = [];
  int? _selectPriority;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CreateTaskBloc()..add(InitialDataEvent()),
      child: BlocConsumer<CreateTaskBloc, CreateTaskState>(
        listener: (context, state) {
          if (state is AddSuccessState) {
            navigator.pop();
          }
        },
        builder: (context, state) {
          if (state is InitialDataState) {
            _stateList = state.stateList;
            _priorityList = state.priorityList;
            _pointList = state.pointList;
            _projectList = state.projectList;
          }

          return Scaffold(
            appBar: AppBar(
              title: Text(localization.createTask),
            ),
            body: Padding(
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
                    decoration: const InputDecoration(labelText: 'Description'),
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
                  // point
                  DropdownButton<String>(
                      value: _selectPoint,
                      hint: Text('Select a point'),
                      items: _pointList.map((String option) {
                        return DropdownMenuItem<String>(
                          value: option,
                          child: Text(option),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectPoint = newValue;
                        });
                      },
                      isExpanded: true),
                  // state
                  DropdownButton<String>(
                      value: _selectState,
                      hint: Text('Select a state'),
                      items: _stateList.map((String option) {
                        return DropdownMenuItem<String>(
                          value: option,
                          child: Text(option),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectState = newValue;
                        });
                      },
                      isExpanded: true),
                  // priority
                  DropdownButton<int>(
                      value: _selectPriority,
                      hint: Text('Select a priority'),
                      items: _priorityList.map((int option) {
                        return DropdownMenuItem<int>(
                          value: option,
                          child: Text('$option'),
                        );
                      }).toList(),
                      onChanged: (int? newValue) {
                        setState(() {
                          _selectPriority = newValue;
                        });
                      },
                      isExpanded: true),
                  // start date
                  InkWell(
                      onTap: () {
                        _pickDate(context, true);
                      },
                      child: ListTile(
                        leading: Icon(Icons.arrow_drop_down),
                        title: Text(
                          _selectStartDate == null
                              ? "Pick a start Date"
                              : "Start Date: ${DateFormat('yyyy-MM-dd').format(_selectStartDate!)}",
                          style: TextStyle(fontSize: 18),
                        ),
                      )),
                  // end date
                  InkWell(
                    onTap: () {
                      _pickDate(context, false);
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
                  ElevatedButton(
                    onPressed: () async {
                      getBloc<CreateTaskBloc>(context).add(AddEvent(TaskEntity(
                          creatorId: '',
                          createdAt: DateFormat("yyyy-MM-ddTHH:mm:ss.SSSSSSZ")
                              .format(DateTime.now()),
                          id: Uuid().v4(),
                          title: _titleController.text,
                          description: _descriptionController.text,
                          state: _selectState ?? '',
                          priority: _selectPriority ?? 1,
                          projectId:
                              _selectProject != null ? _selectProject!.id : '',
                          startDate: _selectStartDate,
                          endDate: _selectEndDate,
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

  Future<void> _pickDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        if (isStartDate) {
          _selectStartDate = picked;
        } else {
          _selectEndDate = picked;
        }
      });
    }
  }
}
