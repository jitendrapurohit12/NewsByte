import 'package:flutter/material.dart';
import 'package:news_shot/helper/method_helper.dart';
import 'package:news_shot/injection.dart';
import 'package:news_shot/models/enums/notifier_state.dart';
import 'package:news_shot/models/failure.dart';
import 'package:news_shot/models/news_model.dart';
import 'package:news_shot/service/api_service.dart';

class SourceNewsNotifier extends ChangeNotifier {
  NewsModel _model;
  Failure _error;
  String _sourceId;
  NotifierState _state = NotifierState.initial;

  NewsModel get model => _model;
  NotifierState get state => _state;
  String get sourceId => _sourceId;
  Failure get error => _error;

  Future<void> reset() async {
    _state = NotifierState.initial;
    _model = null;
    _error = null;
    _sourceId = null;
    notifyListeners();
  }

  Future<void> fetchNews({@required String source}) async {
    assert(source != null);
    _state = NotifierState.fetching;
    _sourceId = source;
    await zeroDelay();
    notifyListeners();
    getIt.get<ApiService>().fetchNews(source: source).then((value) {
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
