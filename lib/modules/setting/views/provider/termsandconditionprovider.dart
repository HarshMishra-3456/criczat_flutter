import 'package:flutter/material.dart';
import 'package:tempalteflutter/modules/setting/data/termsandconapi.dart';
import 'package:tempalteflutter/modules/setting/domain/termsandconditionmodel.dart';


class GettermsandconProvider extends ChangeNotifier {
  final _service = Gettermsandconapis();
  final BuildContext context;
  bool isLoading = false;
  List<TermsandConditionsData> allproduct = [];
  List<TermsandConditionsData> get todos => allproduct;

  GettermsandconProvider(this.context);

  Future<void> getterms() async {
    isLoading = true;
    notifyListeners();

    final response = await _service.Getterms();

    response.fold((l) => null, (r) => allproduct = r.cast<TermsandConditionsData>());

    isLoading = false;
    notifyListeners();

  }
}