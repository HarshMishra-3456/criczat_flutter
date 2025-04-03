import 'package:flutter/material.dart';
import 'package:tempalteflutter/modules/contests/data/getjoinedcontestapi.dart';
import 'package:tempalteflutter/modules/contests/domain/getjoinedcontestmodel.dart';


class GetJoinedContestProvider extends ChangeNotifier {
  final _service = GetJoinedContestapis();
  final BuildContext context;
  bool isLoading = false;
  List<GetJoinedContestData> cricketdata = [];
  List<GetJoinedContestData> get todos => cricketdata;

  GetJoinedContestProvider(this.context);

  Future<void> getcontest() async {
    isLoading = true;
    notifyListeners();

    final response = await _service.Getcontest();

    response.fold((l) => null, (r) => cricketdata = r.cast<GetJoinedContestData>());

    isLoading = false;
    notifyListeners();

  }
}