import 'package:flutter/material.dart';
import 'package:tempalteflutter/modules/standingScreen/data/livematchesapi.dart';
import 'package:tempalteflutter/modules/standingScreen/domain/livematchmodel.dart';


class GetLiveMatchesProvider extends ChangeNotifier {
  final _service = GetLiveMatchesapis();
  final BuildContext context;
  bool isLoading = false;
  List<GetLiveMatchesData> cricketdata = [];
  List<GetLiveMatchesData> get todos => cricketdata;

  GetLiveMatchesProvider(this.context);

  Future<void> getlive() async {
    isLoading = true;
    notifyListeners();

    final response = await _service.Getlivematch();

    response.fold((l) => null, (r) => cricketdata = r.cast<GetLiveMatchesData>());

    isLoading = false;
    notifyListeners();

  }
}