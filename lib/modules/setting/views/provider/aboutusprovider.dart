import 'package:flutter/material.dart';
import 'package:tempalteflutter/modules/setting/data/aboutusapi.dart';
import 'package:tempalteflutter/modules/setting/domain/aboutusmodel.dart';


class GetAboutUsProvider extends ChangeNotifier {
  final _service = GetAboutUsapis();
  final BuildContext context;
  bool isLoading = false;
  List<AboutUsData> cricketdata = [];
  List<AboutUsData> get todos => cricketdata;

  GetAboutUsProvider(this.context);

  Future<void> getabout() async {
    isLoading = true;
    notifyListeners();

    final response = await _service.Getabout();

    response.fold((l) => null, (r) => cricketdata = r.cast<AboutUsData>());

    isLoading = false;
    notifyListeners();

  }
}