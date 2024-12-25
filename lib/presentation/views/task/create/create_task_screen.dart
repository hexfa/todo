import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/core/di/di.dart';
import 'package:todo/core/util/date_time_convert.dart';
import 'package:todo/domain/entities/project.dart';
import 'package:todo/domain/entities/task_data_request.dart';
import 'package:todo/presentation/bloc/create_task/create_task_bloc.dart';
import 'package:todo/presentation/route/app_router.dart';
import 'package:todo/presentation/views/task_state.dart';
import 'package:todo/presentation/views/base/base-state.dart';
import 'package:todo/presentation/views/custom_view/custom_date_picker.dart';
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
  Project? _selectProject;
  final List<TaskState> _priorityList = TaskStateUtils.values;
  TaskState? _selectPriority;
  bool isRecurring = false;

  @override
  void initState() {
    _selectProject = getIt<ProjectProvider>().getProjectName();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double spaceValue = 16;
    return BlocProvider(
      create: (_) => getIt<CreateTaskBloc>(),
      child: BlocConsumer<CreateTaskBloc, CreateTaskState>(
        listener: (context, state) {
          if (state is CreateTaskSuccessState) {
            refreshNotifier = true;
            router.pop();
          }
        },
        builder: (context, state) {
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
                          //content
                          CustomNormalTextField(
                              controller: _titleController,
                              labelText: localization.content),
                          SizedBox(
                            height: spaceValue,
                          ),
                          //description
                          CustomMultiLineTextField(
                              controller: _descriptionController,
                              labelText: localization.description,
                              countLine: 3),
                          SizedBox(
                            height: spaceValue,
                          ),
                          // priority
                          CustomDropdown<TaskState>(
                            selectedValue: _selectPriority,
                            items: _priorityList,
                            hintText: localization.selectATaskState,
                            onValueChanged: (newValue) {
                              _selectPriority = newValue;
                            },
                            itemBuilder: (TaskState state) {
                              return Text(state.name);
                            },
                          ),
                          //start date
                          SizedBox(
                            height: spaceValue,
                          ),
                          CustomDatePicker(
                              selectLabel: localization.startDate,
                              unselectLabel: localization.startDateLabel,
                              selectedDate: _selectStartDate,
                              onDatePicked: (date) {
                                setState(() {
                                  _selectStartDate = date;
                                });
                              }),
                          // end date
                          SizedBox(
                            height: spaceValue,
                          ),
                          CustomDatePicker(
                              selectLabel: localization.endDate,
                              unselectLabel: localization.endDateLabel,
                              selectedDate: _selectEndDate,
                              onDatePicked: (date) {
                                setState(() {
                                  _selectEndDate = date;
                                });
                              }),
                          SizedBox(
                            height: spaceValue,
                          ),
                          //recurring
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
                              if (isEmptyData()) {
                                showSnackBar(
                                    localization.pleaseFillInAllFields);
                              } else if (checkSelectDates()) {
                                showSnackBar(
                                    localization.theDatesCannotBeBeforeToday);
                              } else if (isCorrectEndDate()) {
                                showSnackBar(
                                    localization.endDateCannotBeBeforeStart);
                              } else {
                                getBloc<CreateTaskBloc>(context).add(
                                    ConfirmCreateTaskEvent(
                                        TaskDataEntityRequest(
                                            content: _titleController.text,
                                            description: _descriptionController
                                                .text,
                                            startDate: DateTimeConvert
                                                .convertDateToString(
                                                    _selectStartDate!),
                                            deadLine: DateTimeConvert
                                                .convertDateToString(
                                                    _selectEndDate!),
                                            projectId: _selectProject!.id,
                                            priority:
                                                _selectPriority!.serverValue)));
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

  bool isCorrectEndDate() {
    return !DateTimeConvert.isSecondDateValid(
        _selectStartDate!, _selectEndDate!);
  }

  bool checkSelectDates() {
    return DateTimeConvert.isDateBeforeToday(_selectStartDate!) ||
        DateTimeConvert.isDateBeforeToday(_selectEndDate!);
  }

  bool isEmptyData() {
    return _titleController.text.isEmpty ||
        _descriptionController.text.isEmpty ||
        _selectProject == null ||
        _selectPriority == null ||
        _selectStartDate == null ||
        _selectEndDate == null;
  }
}
