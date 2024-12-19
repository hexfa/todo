import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:todo/gen/assets.gen.dart';

class StateWidget extends StatefulWidget{
  final String? message;
  final bool isLoading;

   StateWidget(this.message, {super.key, required this.isLoading});

  @override
  State<StateWidget> createState() => _StateWidgetState();
}

class _StateWidgetState extends State<StateWidget> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          widget.isLoading?
          Lottie.asset(Assets.animations.loding,fit: BoxFit.scaleDown,width: 100,height: 100):
          Opacity(opacity: 0.8,
          child: Lottie.asset(Assets.animations.empty,fit: BoxFit.fill,width: 250,height: 250)),

          if(!widget.isLoading)
          Opacity(
            opacity: 0.7,
            child: Text(
              widget.message??'Nothing to see here',
              style: theme.textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
          ),

        ],
      ),
    );
  }
}