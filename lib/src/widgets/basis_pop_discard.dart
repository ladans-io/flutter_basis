import 'package:flutter/material.dart';
import 'package:flutter_basis/flutter_basis.dart';

class BasisPopDiscard extends StatelessWidget {
  const BasisPopDiscard({
    super.key,
    required this.condition,
    required this.child,
  });

  final bool condition;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      child: child,
      canPop: false,
      onPopInvoked: (_) {
        if (condition) {
          showDialog(context: context, builder: (_) {
            return BasisPopupAlert(
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
      },
    );
  }
}