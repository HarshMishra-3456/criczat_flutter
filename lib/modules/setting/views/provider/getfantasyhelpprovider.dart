import 'package:flutter/material.dart';
import 'package:tempalteflutter/modules/setting/data/getfantasyhelpapi.dart';
import 'package:tempalteflutter/modules/setting/domain/getfantasyhelpmodel.dart';


class FantasyHelpProvider extends ChangeNotifier {
  final _service = FantasyHelpapis();
  final BuildContext context;
  bool isLoading = false;
  List<FantasyHelpData> cricketdata = [];
  List<FantasyHelpData> get todos => cricketdata;

  FantasyHelpProvider(this.context);

  Future<void> gethelp() async {
    isLoading = true;
    notifyListeners();

    final response = await _service.Gethelp();

    response.fold((l) => null, (r) => cricketdata = r.cast<FantasyHelpData>());

    isLoading = false;
    notifyListeners();

  }
}