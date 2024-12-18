import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/core/di/di.dart';
import 'package:todo/core/theme/theme.dart';
import 'package:todo/presentation/bloc/project_bloc.dart';
import 'package:todo/presentation/bloc/project_event.dart';
import 'package:todo/presentation/bloc/project_state.dart';
import 'package:todo/presentation/views/app_drawer.dart';
import 'package:todo/presentation/views/base/base-state.dart';
import 'package:todo/presentation/views/fab.dart';
import 'package:todo/presentation/views/state_widget.dart';



class ProjectsPage extends StatefulWidget {
  const ProjectsPage({super.key});
  @override
  State<ProjectsPage> createState() => _ProjectsPageState();
}

class _ProjectsPageState extends BaseState<ProjectsPage> {
  bool showFab = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext buildContext) {
    return ThemeSwitchingArea(
      child: BlocProvider(
        create: (context) => getIt<ProjectsBloc>()..add(FetchProjectsEvent()),
        child: Scaffold(
          drawer: AppDrawer(),
          floatingActionButton: showFab ? FAB() : null,
          appBar: AppBar(
              title: Text(
            'Projects',
            style: theme.textTheme.titleMedium
                ?.copyWith(color: theme.colorScheme.onPrimary),
          )),
          body: BlocConsumer<ProjectsBloc, ProjectsState>(
            listener: (context, state) {
              if (state is ProjectsError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
                context.read<ProjectsBloc>().add(FetchProjectsEvent());
              }
              if (state is ProjectCreateSuccess ||
                  state is DeleteProjectState) {
                context.read<ProjectsBloc>().add(FetchProjectsEvent());
              }
              if (state is ProjectsLoaded) {
                setState(() {
                  showFab = state.projects.length < 8;
                });
              }
            },
            builder: (context, state) {
              if (state is ProjectsLoading) {
                return StateWidget(isLoading: true, null);
              } else if (state is ProjectsLoaded) {
                if (state.projects.isEmpty) {
                  return StateWidget(isLoading: false, localization.createProject);
                } else {
                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 3 / 2,
                    ),
                    padding: const EdgeInsets.all(10),
                    itemCount: state.projects.length,
                    itemBuilder: (gridContext, index) {
                      final project = state.projects[index];
                      return Card(
                        elevation: 4,
                        margin: const EdgeInsets.all(4),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                gradiantColors[index],
                                theme.primaryColor
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Stack(
                            children: [
                              Center(
                                child: Text(
                                  project.name,
                                  style: theme.textTheme.titleMedium
                                      ?.copyWith(color: Colors.white),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              project.name != 'Inbox'
                                  ? Positioned(
                                      top: 8,
                                      left: 8,
                                      child: IconButton(
                                        icon: Icon(Icons.close,
                                            color: Colors.white),
                                        onPressed: () {
                                          showDialog(
                                            context: gridContext,
                                            builder:
                                                (BuildContext dialogContext) {
                                              return AlertDialog(
                                                title: Text(localization
                                                        .confirmDeletion ),
                                                content: Text(localization
                                                        .wantConfirmDeletion ),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(
                                                              dialogContext)
                                                          .pop();
                                                    },
                                                    child: Text(
                                                        localization.cancel ),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      context
                                                          .read<ProjectsBloc>()
                                                          .add(
                                                              DeleteProjectEvent(
                                                                  project.id));
                                                      Navigator.of(
                                                              dialogContext)
                                                          .pop();
                                                    },
                                                    child: Text(
                                                        localization.delete),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                      ),
                                    )
                                  : SizedBox.shrink(),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              } else if (state is ProjectsError) {
                return  Center(child: Text(localization.somethingWentWrong));
              }
              return SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}