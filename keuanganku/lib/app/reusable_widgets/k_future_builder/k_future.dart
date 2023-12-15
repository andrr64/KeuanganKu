import 'package:flutter/material.dart';

class KFutureBuilder {
  static Widget build({
    required BuildContext context,
    required Future<dynamic> future,
    required Widget Function() buildWhenSuccess,
    required Widget Function() buildWhenEmpty,
    required Widget Function() buildWhenError,
    Widget Function()? buildWhenWaiting,
  }) {
    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return buildWhenWaiting?.call() ?? const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return buildWhenError();
        } else if (snapshot.hasData) {
          if (snapshot.data == null) {
            return buildWhenEmpty();
          } else {
            return buildWhenSuccess();
          }
        } else {
          return buildWhenEmpty();
        }
      },
    );
  }
}
