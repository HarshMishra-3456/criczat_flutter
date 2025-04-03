import 'package:flutter/material.dart';
import 'package:tempalteflutter/modules/standingScreen/data/completematchapi.dart';
import 'package:tempalteflutter/modules/standingScreen/domain/completedmatchmodel.dart';


class GetCompleteMatchesProvider extends ChangeNotifier {
  final _service = GetCompleteMatchesapis();
  final BuildContext context;
  bool isLoading = false;
  List<GetCompleteMatchesData> cricketdata = [];
  List<GetCompleteMatchesData> get todos => cricketdata;

  GetCompleteMatchesProvider(this.context);

  Future<void> getcomplete() async {
    isLoading = true;
    notifyListeners();

    final response = await _service.Getcompletematch();

    response.fold((l) => null, (r) => cricketdata = r.cast<GetCompleteMatchesData>());

    isLoading = false;
    notifyListeners();

  }
}