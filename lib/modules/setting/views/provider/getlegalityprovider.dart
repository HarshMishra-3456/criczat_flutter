import 'package:flutter/material.dart';
import 'package:tempalteflutter/modules/setting/data/legalityapi.dart';
import 'package:tempalteflutter/modules/setting/domain/legalitymodel.dart';


class FantasyLegalityProvider extends ChangeNotifier {
  final _service = GetFantasyLegalityapis();
  final BuildContext context;
  bool isLoading = false;
  List<FantasyLegalityData> cricketdata = [];
  List<FantasyLegalityData> get todos => cricketdata;

  FantasyLegalityProvider(this.context);

  Future<void> getlegality() async {
    isLoading = true;
    notifyListeners();

    final response = await _service.Getlegality();

    response.fold((l) => null, (r) => cricketdata = r.cast<FantasyLegalityData>());

    isLoading = false;
    notifyListeners();

  }
}