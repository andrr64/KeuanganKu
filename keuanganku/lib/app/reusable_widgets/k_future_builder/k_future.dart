import 'package:flutter/material.dart';

/// Class ini digunakan untuk mempermudah penggunaan FutureBuilder
class KFutureBuilder {
  static Widget build<T>({
    required BuildContext context,
    required Future<T> future,
    required Widget Function(T) buildWhenSuccess,
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
            return buildWhenSuccess(snapshot.data as T);
          }
        } else {
          return buildWhenEmpty();
        }
      },
    );
  }
}
