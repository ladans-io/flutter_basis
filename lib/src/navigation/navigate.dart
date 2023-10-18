import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'err.dart';

class Navigate {
  
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Navigate._();
  static final Navigate to = Navigate._();
  factory Navigate() => to;

  Future<T?> pushNamed<T extends Object?>(String routeName, {Object? arguments}) async {
    try {
      return await navigatorKey.currentState?.pushNamed<T>(routeName, arguments: arguments);
    } catch (e) {
      log('A error found: ', error: getNavigationErrorPrettly(e.toString(), route: routeName));
      return null;
    }
  }

  Future<T?> pushNamedAndRemoveUntil<T extends Object?>(String routeName, bool Function(Route<dynamic>) predicate, {Object? arguments}) async {
    try {
      return await navigatorKey.currentState?.pushNamedAndRemoveUntil<T>(routeName, predicate, arguments: arguments);
    } catch (e) {
      log('A error found: ', error: getNavigationErrorPrettly(e.toString(), route: routeName));
      return null;
    }
  }

  Future<T?> pushReplacementNamed<T extends Object?, TO extends Object?>(String routeName, {Object? arguments}) async {
    try {
      return await navigatorKey.currentState?.pushReplacementNamed<T, TO>(routeName, arguments: arguments);
    } catch (e) {
      log('A error found: ', error: getNavigationErrorPrettly(e.toString(), route: routeName));
      return null;
    }
  }

  Future<T?> popAndPushNamed<T extends Object?, TO extends Object?>(String routeName, {TO? result, Object? arguments}) async {
    try {
      return await navigatorKey.currentState?.popAndPushNamed<T, TO>(routeName, result: result, arguments: arguments);
    } catch (e) {
      log('A error found: ', error: getNavigationErrorPrettly(e.toString(), route: routeName));
      return null;
    }
  }

  void pop<T extends Object?>([T? result]) {
    try {
      navigatorKey.currentState?.pop<T>(result);
    } catch (e) {
      log('A error found: ', error: getNavigationErrorPrettly(e.toString()));
    }
  }

}