import 'package:flutter/material.dart';
import 'package:news_shot/constant/constant.dart';

class CategoryNotifier extends ChangeNotifier {
  String _category = kCategories[0];

  String get category => _category;

  Future<void> reset() async {
    _category = kCategories[0];
    notifyListeners();
  }

  Future<void> setCategory({@required String category}) async {
    assert(category != null);
    _category = category;
    notifyListeners();
  }
}
