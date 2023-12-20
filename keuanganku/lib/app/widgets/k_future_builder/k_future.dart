import 'package:flutter/material.dart';

class KFutureBuilder {
  static Widget build<T>({
    required Future<T> future,
    required Widget whenError,
    required Widget Function(T) whenSuccess,
    Widget? whenWaiting,

  }){
    return FutureBuilder(
        future: future,
        builder: (_, snapshot){
          if (snapshot.connectionState == ConnectionState.waiting){
            return whenWaiting ?? const CircularProgressIndicator();
          } else if (snapshot.hasError){
            return whenError;
          } else {
            return whenSuccess(snapshot.data as T);
          }
        });
  }
}