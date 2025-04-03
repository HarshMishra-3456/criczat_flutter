import 'package:flutter/material.dart';
import 'package:tempalteflutter/modules/contests/data/getcontestbymatchapi.dart';
import 'package:tempalteflutter/modules/contests/domain/getcntestbymatchmodel.dart';


class GetContestByMatchProvider extends ChangeNotifier {
  final _service = GetContestByMatchapis();
  final BuildContext context;
  bool isLoading = false;
  List<GetContestByMatchIdData> cricketdata = [];
  List<GetContestByMatchIdData> get todos => cricketdata;

  GetContestByMatchProvider(this.context);

  Future<void> getcontest() async {
    isLoading = true;
    notifyListeners();

    final response = await _service.Getcontest();

    response.fold((l) => null, (r) => cricketdata = r.cast<GetContestByMatchIdData>());

    isLoading = false;
    notifyListeners();

  }
}