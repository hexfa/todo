import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

/// BaseStatelessWidget provides common utilities and methods for stateless widgets
abstract class BaseStatelessWidget extends StatelessWidget {
  const BaseStatelessWidget({super.key});

  // Theme Data for accessing the current theme
  ThemeData theme(BuildContext context) => Theme.of(context);

  // Localization for accessing localized strings
  AppLocalizations localization(BuildContext context) =>
      AppLocalizations.of(context)!;

  // Access to Navigator for pushing and popping pages
  NavigatorState navigator(BuildContext context) => Navigator.of(context);

  // Access to GoRouter for navigating between pages
  GoRouter router(BuildContext context) => GoRouter.of(context);

  // Common method to show a SnackBar with a message
  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  // Method to handle errors (could be customized based on app requirements)
  void handleError(BuildContext context, Object error, StackTrace stackTrace) {
    showSnackBar(context, "An error occurred: ${error.toString()}");
    // Log errors or send them to an analytics service here if needed
  }

  // Get bloc object
  TBloc getBloc<TBloc extends Bloc>(BuildContext context) =>
      BlocProvider.of<TBloc>(context);

  @override
  Widget build(BuildContext context);
}
