import 'package:flutter/material.dart';
import 'package:flutter_basis/flutter_basis.dart';

class FWillPopDiscard extends StatelessWidget {
  const FWillPopDiscard({
    super.key,
    required this.condition,
    required this.child,
  });

  final bool condition;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: child,
      onWillPop: () async {
        if (condition) {
          showDialog(context: context, builder: (_) {
            return FAlertDialog(
              title: 'Deseja descartar?',
              confirmLabel: 'Sim',
              cancelLabel: 'Não',
              cancelable: true,
              onPressed: () {
                Navigate.to.pop();
                Navigate.to.pop();
              },
            );
          });
        }

        return true;
      },
    );
  }
}