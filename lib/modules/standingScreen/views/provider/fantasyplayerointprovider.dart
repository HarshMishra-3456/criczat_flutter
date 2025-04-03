import 'package:flutter/material.dart';
import 'package:tempalteflutter/modules/standingScreen/data/fantasyplayerpointapi.dart';
import 'package:tempalteflutter/modules/standingScreen/domain/getfantasyplayerpoint.dart';


class GetFantasyPlayerPointProvider extends ChangeNotifier {
  final _service = GetFantasyPlayerPointapis();
  final BuildContext context;
  bool isLoading = false;
  GetFantasyPlayerPoint? cricketdata;
  GetFantasyPlayerPoint? get todos => cricketdata;

  GetFantasyPlayerPointProvider(this.context);

  Future<void> getplayerpoint() async {
    isLoading = true;
    notifyListeners();

    final response = await _service.Getlivematch();

    response.fold((l) => null, (r) => cricketdata = r);

    isLoading = false;
    notifyListeners();

  }
}