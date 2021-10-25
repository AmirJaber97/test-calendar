import 'package:flutter/material.dart';

enum NotifierState { initial, loading, loaded }

class BaseProvider extends ChangeNotifier {
  NotifierState _state = NotifierState.initial;

  NotifierState get state => _state;

  void setNotifier(NotifierState state) {
    _state = state;
    notifyListeners();
  }
}
