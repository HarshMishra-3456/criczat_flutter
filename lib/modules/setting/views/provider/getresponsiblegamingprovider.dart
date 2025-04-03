import 'package:flutter/material.dart';
import 'package:tempalteflutter/modules/setting/data/getresponsiblegamingapi.dart';
import 'package:tempalteflutter/modules/setting/domain/getresponsiblegamingmodel.dart';


class ResponsibleGamingProvider extends ChangeNotifier {
  final _service = GetResponsibleGamingapis();
  final BuildContext context;
  bool isLoading = false;
  List<ResponsibleGamingData> cricketdata = [];
  List<ResponsibleGamingData> get todos => cricketdata;

  ResponsibleGamingProvider(this.context);

  Future<void> getgaming() async {
    isLoading = true;
    notifyListeners();

    final response = await _service.Getgaming();

    response.fold((l) => null, (r) => cricketdata = r.cast<ResponsibleGamingData>());

    isLoading = false;
    notifyListeners();

  }
}