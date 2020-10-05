import 'package:flutter/material.dart';

class DashboardSelectionNotifier extends ChangeNotifier {
  int _page = 0;

  int getPage() => _page;

  Future<void> reset() async {
    _page = 0;
    notifyListeners();
  }

  Future<void> setPage({@required int pageNo}) async {
    assert(pageNo != null);
    _page = pageNo;
    notifyListeners();
  }
}
