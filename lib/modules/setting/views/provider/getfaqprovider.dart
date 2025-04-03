import 'package:flutter/material.dart';
import 'package:tempalteflutter/modules/setting/data/getfaqapi.dart';
import 'package:tempalteflutter/modules/setting/data/privacypolicyapi.dart';
import 'package:tempalteflutter/modules/setting/domain/fantasyfaqmodel.dart';
import 'package:tempalteflutter/modules/setting/domain/privacypolicymodel.dart';


class FantasyFaqProvider extends ChangeNotifier {
  final _service = GetFantasyFaqapis();
  final BuildContext context;
  bool isLoading = false;
  List<FantasyFaqData> cricketdata = [];
  List<FantasyFaqData> get todos => cricketdata;

  FantasyFaqProvider(this.context);

  Future<void> getfaq() async {
    isLoading = true;
    notifyListeners();

    final response = await _service.Getfaq();

    response.fold((l) => null, (r) => cricketdata = r.cast<FantasyFaqData>());

    isLoading = false;
    notifyListeners();

  }
}