import 'package:flutter/material.dart';
import 'package:tempalteflutter/modules/myProfile/data/getalltransactionapi.dart';
import 'package:tempalteflutter/modules/myProfile/domain/getalltransactionmodel.dart';


class GetUserAllTransactionProvider extends ChangeNotifier {
  final _service = GetUserAllTransactionapis();
  final BuildContext context;
  bool isLoading = false;
  List<GetUserAllTransactionData> cricketdata = [];
  List<GetUserAllTransactionData> get todos => cricketdata;

  GetUserAllTransactionProvider(this.context);

  Future<void> gettransaction() async {
    isLoading = true;
    notifyListeners();

    final response = await _service.Gettransaction();

    response.fold((l) => null, (r) => cricketdata = r.cast<GetUserAllTransactionData>());

    isLoading = false;
    notifyListeners();

  }
}