import 'package:flutter/material.dart';
import 'package:tempalteflutter/modules/setting/data/privacypolicyapi.dart';
import 'package:tempalteflutter/modules/setting/domain/privacypolicymodel.dart';


class PrivacyPolicyProvider extends ChangeNotifier {
  final _service = GetPrivacypolicyapis();
  final BuildContext context;
  bool isLoading = false;
  List<PrivacyPolicyData> cricketdata = [];
  List<PrivacyPolicyData> get todos => cricketdata;

  PrivacyPolicyProvider(this.context);

  Future<void> getprivacy() async {
    isLoading = true;
    notifyListeners();

    final response = await _service.Getprivacy();

    response.fold((l) => null, (r) => cricketdata = r.cast<PrivacyPolicyData>());

    isLoading = false;
    notifyListeners();

  }
}