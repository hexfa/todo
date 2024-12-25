import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:todo/gen/assets.gen.dart';
import 'package:todo/presentation/views/base/base-state.dart';

class StateWidget extends StatefulWidget {
  final String? message;
  final bool isLoading;

  const StateWidget(this.message, {super.key, required this.isLoading});

  @override
  State<StateWidget> createState() => _StateWidgetState();
}

class _StateWidgetState extends BaseState<StateWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          widget.isLoading
              ? Lottie.asset(Assets.animations.loding,
                  fit: BoxFit.scaleDown, width: 100, height: 100)
              : Opacity(
                  opacity: 0.8,
                  child: Lottie.asset(Assets.animations.empty,
                      fit: BoxFit.fill, width: 250, height: 250)),
          if (!widget.isLoading)
            Opacity(
              opacity: 0.7,
              child: Text(
                widget.message ?? localization.nothingToSeeHere,
                style: theme.textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
            ),
        ],
      ),
    );
  }
}
