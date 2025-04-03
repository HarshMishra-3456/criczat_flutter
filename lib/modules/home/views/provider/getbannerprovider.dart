import 'package:flutter/material.dart';
import 'package:tempalteflutter/modules/home/data/getbannerapi.dart';
import 'package:tempalteflutter/modules/home/domain/getbannermodel.dart';


class GetBannerProvider extends ChangeNotifier {
  final _service = GetBannerapis();
  final BuildContext context;
  bool isLoading = false;
  List<BannerData> cricketdata = [];
  List<BannerData> get todos => cricketdata;

  GetBannerProvider(this.context);

  Future<void> getbanner() async {
    isLoading = true;
    notifyListeners();

    final response = await _service.Getbanner();

    response.fold((l) => null, (r) => cricketdata = r.cast<BannerData>());

    isLoading = false;
    notifyListeners();

  }
}