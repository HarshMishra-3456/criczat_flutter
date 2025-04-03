import 'package:flutter/material.dart';
import 'package:tempalteflutter/modules/setting/data/getcontactusapi.dart';
import 'package:tempalteflutter/modules/setting/domain/getcontactusmodel.dart';


class ContactusProvider extends ChangeNotifier {
  final _service = GetContactusapis();
  final BuildContext context;
  bool isLoading = false;
  List<ContactusData> cricketdata = [];
  List<ContactusData> get todos => cricketdata;

  ContactusProvider(this.context);

  Future<void> getcontact() async {
    isLoading = true;
    notifyListeners();

    final response = await _service.Getcontact();

    response.fold((l) => null, (r) => cricketdata = r.cast<ContactusData>());

    isLoading = false;
    notifyListeners();

  }
}