import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/core/di/di.dart';
import 'package:todo/core/util/date_time_convert.dart';
import 'package:todo/domain/entities/project.dart';
import 'package:todo/domain/entities/task_data_request.dart';
import 'package:todo/presentation/bloc/create_task/create_task_bloc.dart';
import 'package:todo/presentation/route/app_router.dart';
import 'package:todo/presentation/views/base/base-state.dart';
import 'package:todo/presentation/views/custom_view/custom_dropdown_button.dart';
import 'package:todo/presentation/views/custom_view/custom_multiline_text_field.dart';
import 'package:todo/presentation/views/custom_view/custom_normal_text_field.dart';
import 'package:todo/presentation/views/state_widget.dart';
import 'package:todo/presentation/views/task/create/project_provider.dart';

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
  List<Project> _projectList = [];
  Project? _selectProject;
  final List<String> _priorityList = ['todo', 'inProgress', 'done'];
  String? _selectPriority;
  bool isRecurring = false;

  @override
  Widget build(BuildContext context) {
    double borderRadius = 12;
    double spaceValue = 16;
    return BlocProvider(
      create: (_) => getIt<CreateTaskBloc>()..add(InitialDataEvent()),
      child: BlocConsumer<CreateTaskBloc, CreateTaskState>(
        listener: (context, state) {
          if (state is AddSuccessState) {
            refreshNotifier = true;
            router.pop();
          }
        },
        builder: (context, state) {
          if (state is InitialDataState) {
            _projectList = state.projectList;
            _selectProject = getIt<ProjectProvider>().getProjectName();
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
                : SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 24),
                      child: Column(
                        children: [
                          CustomNormalTextField(
                              controller: _titleController,
                              labelText: localization.content),
                          SizedBox(
                            height: spaceValue,
                          ),
                          CustomMultiLineTextField(
                              controller: _descriptionController,
                              labelText: localization.description,
                              countLine: 3),
                          // project
                          SizedBox(
                            height: spaceValue,
                          ),
                          // priority
                          CustomDropdown<String>(
                            selectedValue: _selectPriority,
                            items: _priorityList,
                            hintText: localization.selectATaskState,
                            onValueChanged: (newValue) {
                              _selectPriority = newValue;
                            },
                          ),
                          //start date
                          SizedBox(
                            height: spaceValue,
                          ),
                          InkWell(
                              onTap: () {
                                _pickDate(context, true);
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
                                    _selectStartDate == null
                                        ? localization.startDateLabel
                                        : "${localization.startDate} at ${DateTimeConvert.convertDateToString(_selectStartDate!)}",
                                    style: theme.textTheme.bodyMedium,
                                  ),
                                ),
                              )),
                          // end date
                          SizedBox(
                            height: spaceValue,
                          ),
                          InkWell(
                              onTap: () {
                                _pickDate(context, false);
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
                                        : "${localization.endDate} at ${DateTimeConvert.convertDateToString(_selectEndDate!)}",
                                    style: theme.textTheme.bodyMedium,
                                  ),
                                ),
                              )),
                          SizedBox(
                            height: spaceValue,
                          ),
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
                          SizedBox(
                            height: spaceValue,
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              if (_titleController.text.isEmpty ||
                                  _descriptionController.text.isEmpty ||
                                  _selectProject == null ||
                                  _selectPriority == null ||
                                  _selectStartDate == null ||
                                  _selectEndDate == null) {
                                showSnack(context,
                                    localization.pleaseFillInAllFields);
                              } else if (DateTimeConvert.isDateBeforeToday(
                                      _selectStartDate!) ||
                                  DateTimeConvert.isDateBeforeToday(
                                      _selectEndDate!)) {
                                showSnack(context,
                                    localization.theDatesCannotBeBeforeToday);
                              } else if (!DateTimeConvert.isSecondDateValid(
                                  _selectStartDate!, _selectEndDate!)) {
                                showSnack(context,
                                    localization.endDateCannotBeBeforeStart);
                              } else {
                                getBloc<CreateTaskBloc>(context).add(AddEvent(
                                    TaskDataEntityRequest(
                                        content: _titleController.text,
                                        description:
                                            _descriptionController.text,
                                        startDate:
                                            DateTimeConvert.convertDateToString(
                                                _selectStartDate!),
                                        deadLine:
                                            DateTimeConvert.convertDateToString(
                                                _selectEndDate!),
                                        projectId: _selectProject!.id,
                                        priority: getSelectPriority())));
                              }
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
                  ),
          );
        },
      ),
    );
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnack(
      BuildContext context, String message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
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
