import 'package:flutter/material.dart';
import 'package:tempalteflutter/modules/drawer/data/getoffersapi.dart';
import 'package:tempalteflutter/modules/drawer/domain/getoffersmodel.dart';


class GetOffersandProgramProvider extends ChangeNotifier {
  final _service = GetOffersandProgramapis();
  final BuildContext context;
  bool isLoading = false;
  List<GetOffersandProgramData> cricketdata = [];
  List<GetOffersandProgramData> get todos => cricketdata;

  GetOffersandProgramProvider(this.context);

  Future<void> getoffer() async {
    isLoading = true;
    notifyListeners();

    final response = await _service.Getabout();

    response.fold((l) => null, (r) => cricketdata = r.cast<GetOffersandProgramData>());

    isLoading = false;
    notifyListeners();

  }
}