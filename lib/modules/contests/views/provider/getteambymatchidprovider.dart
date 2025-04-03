import 'package:flutter/material.dart';
import 'package:tempalteflutter/modules/contests/data/getteambymatchidapi.dart';
import 'package:tempalteflutter/modules/contests/domain/getteambymatchid.dart';


class GetTeamByMatchIdProvider extends ChangeNotifier {
  final _service = GetTeamByMatchIdapis();
  final BuildContext context;
  bool isLoading = false;
  GetTeamByMatchId? cricketdata;
  GetTeamByMatchId? get todos => cricketdata;

  GetTeamByMatchIdProvider(this.context);

  Future<void> getteam() async {
    isLoading = true;
    notifyListeners();

    final response = await _service.Getteam();

    response.fold((l) => null, (r) => cricketdata = r);

    isLoading = false;
    notifyListeners();

  }
}