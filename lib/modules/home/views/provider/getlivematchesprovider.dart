import 'package:flutter/material.dart';
import 'package:tempalteflutter/modules/home/data/getlivematchesapi.dart';
import 'package:tempalteflutter/modules/home/domain/getlivematchesmodel.dart';

class GetLiveMatchProvider extends ChangeNotifier {
  final _service = GetLiveMatchapis();
  final BuildContext context;
  bool isLoading = false;
  List<LiveItem> cricketdata = [];
  List<LiveItem> get todos => cricketdata;

  GetLiveMatchProvider(this.context);

  Future<void> getmatch() async {
    isLoading = true;
    notifyListeners();

    final response = await _service.Getlive();

    response.fold((l) => null, (r) => cricketdata = r.cast<LiveItem>());

    isLoading = false;
    notifyListeners();

  }
}