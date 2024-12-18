import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

/// BaseState is a reusable class that provides common functionality
/// for other widgets in the app by extending StatefulWidget.
abstract class BaseState<T extends StatefulWidget> extends State<T> {
  // Theme Data for accessing the current theme
  late GoRouter router;

  // Method to initialize app-wide dependencies (like network requests, etc.)
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    router = GoRouter.of(context);
  }

  ThemeData get theme => Theme.of(context);

  // Localization for accessing localized strings
  AppLocalizations get localization => AppLocalizations.of(context)!;

  // Access to Navigator for pushing and popping pages
  NavigatorState get navigator => Navigator.of(context);

  // Common method to show a SnackBar with a message
  void showSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  // Common method to handle errors (could be customized based on app requirements)
  void handleError(Object error, StackTrace stackTrace) {
    showSnackBar("An error occurred: ${error.toString()}");
    // You can log errors or send them to an analytics service here
  }

  // Get bloc object
  TBloc getBloc<TBloc extends Bloc>(BuildContext context) =>
      BlocProvider.of<TBloc>(context);

  @override
  Widget build(BuildContext context) {
    return Container(); // This should be overridden in subclasses
  }
}
