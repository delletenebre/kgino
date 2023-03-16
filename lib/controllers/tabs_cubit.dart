
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TabsCubit extends Cubit<int> {
  final focusNodes = [
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
  ];
    
  TabsCubit(int selectedTabIndex) : super(selectedTabIndex);

  void updateSelected(int value) {
    if (!isClosed) {
      emit(value);
    }
  }

  void requestFocus() {
    focusNodes[state].requestFocus();
  }
}
