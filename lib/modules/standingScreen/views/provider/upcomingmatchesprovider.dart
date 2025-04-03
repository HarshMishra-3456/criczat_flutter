import 'package:flutter/material.dart';
import 'package:tempalteflutter/modules/standingScreen/data/upcomingmatchesapi.dart';
import 'package:tempalteflutter/modules/standingScreen/domain/upcomingmatchmodel.dart';


class GetUpcomingMatchesProvider extends ChangeNotifier {
  final _service = GetUpcomingMatchesapis();
  final BuildContext context;
  bool isLoading = false;
  List<GetUpcomingMatchesData> cricketdata = [];
  List<GetUpcomingMatchesData> get todos => cricketdata;

  GetUpcomingMatchesProvider(this.context);

  Future<void> getupcoming() async {
    isLoading = true;
    notifyListeners();

    final response = await _service.Getupcomingmatch();

    response.fold((l) => null, (r) => cricketdata = r.cast<GetUpcomingMatchesData>());

    isLoading = false;
    notifyListeners();

  }
}