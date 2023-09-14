// import 'package:flutter/material.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

mixin ValueMixins<T> on AutoDisposeNotifier<T> {
  T get value => state;
}

// mixin FormMixins<T> on AsyncNotifier<T> {
//   final formKey = GlobalKey<FormBuilderState>();
//   FormBuilderState? get form => formKey.currentState;
// }
