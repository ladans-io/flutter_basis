import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_basis/flutter_basis.dart';

class BasisPopScope extends StatefulWidget {
  const BasisPopScope({
    super.key,
    required this.child,
  });
  final Widget child;

  @override
  State<BasisPopScope> createState() => _BasisPopScopeState();
}

class _BasisPopScopeState extends State<BasisPopScope> {
  var _taps = 0;

  Future<bool> _onWillPop() async {
    if (_taps == 0) _taps += 1;
    if (_taps == 1) {
      BasisAlert.show(
        message: 'Clique novamente para encerrar a aplicação!',
        state: ESnackBarState.info,
      );
      _taps += 1;
    } else if (_taps == 2) {
      exit(0);
    }
    Future.delayed(const Duration(seconds: 6), () => _taps = 0);

    return false;
  }

  @override
  Widget build(BuildContext _) => WillPopScope(
    onWillPop: _onWillPop,
    child: widget.child,
  );
}