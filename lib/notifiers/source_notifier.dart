import 'package:flutter/material.dart';
import 'package:news_shot/helper/method_helper.dart';
import 'package:news_shot/injection.dart';
import 'package:news_shot/models/enums/notifier_state.dart';
import 'package:news_shot/models/failure.dart';
import 'package:news_shot/models/source_model.dart';
import 'package:news_shot/service/api_service.dart';

class SourceNotifier extends ChangeNotifier {
  SourceModel _model;
  Failure _error;
  NotifierState _state = NotifierState.initial;

  SourceModel get model => _model;
  NotifierState get state => _state;
  Failure get error => _error;

  Future<void> reset() async {
    _state = NotifierState.initial;
    _model = null;
    _error = null;
    notifyListeners();
  }

  Future<void> fetchSource() async {
    _state = NotifierState.fetching;
    await zeroDelay();
    notifyListeners();
    getIt.get<ApiService>().fetchSources().then((value) {
      _model = value;
      _state = NotifierState.loaded;
      notifyListeners();
    }).catchError((e) {
      _error = e as Failure;
      _state = NotifierState.error;
      notifyListeners();
    });
  }
}
