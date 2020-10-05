import 'package:flutter/material.dart';
import 'package:news_shot/helper/method_helper.dart';
import 'package:news_shot/injection.dart';
import 'package:news_shot/models/enums/notifier_state.dart';
import 'package:news_shot/models/failure.dart';
import 'package:news_shot/models/news_model.dart';
import 'package:news_shot/service/api_service.dart';

class NewsNotifier extends ChangeNotifier {
  NewsModel _model;
  Failure _error;
  String _category;
  NotifierState _state = NotifierState.initial;

  NewsModel get model => _model;
  NotifierState get state => _state;
  String get category => _category;
  Failure get error => _error;

  Future<void> reset() async {
    _state = NotifierState.initial;
    _model = null;
    _error = null;
    _category = null;
    notifyListeners();
  }

  Future<void> fetchNews({@required String category}) async {
    assert(category != null);
    _category = category;
    _state = NotifierState.fetching;
    await zeroDelay();
    notifyListeners();
    getIt.get<ApiService>().fetchNews(category: category).then((value) {
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
