import 'package:flutter/material.dart';
import 'package:tempalteflutter/modules/home/data/getupcomingmatchapi.dart';
import 'package:tempalteflutter/modules/home/domain/getupcomingmatchmodel.dart';

class GetUpcomingMatchProvider extends ChangeNotifier {
  final _service = GetUpcomingMatchapis();
  final BuildContext context;
  bool isLoading = false;
  List<UpcomingItem> cricketdata = [];
  List<UpcomingItem> get todos => cricketdata;

  GetUpcomingMatchProvider(this.context);

  Future<void> getmatch() async {
    isLoading = true;
    notifyListeners();

    final response = await _service.Getupcoming();

    response.fold((l) => null, (r) => cricketdata = r.cast<UpcomingItem>());

    isLoading = false;
    notifyListeners();

  }
}