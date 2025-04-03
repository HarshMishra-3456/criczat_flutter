import 'package:flutter/material.dart';
import 'package:tempalteflutter/modules/myProfile/data/getusernotificationapi.dart';
import 'package:tempalteflutter/modules/myProfile/domain/getusernotificationmodel.dart';


class GetUserNotificationProvider extends ChangeNotifier {
  final _service = GetUserNotificationapis();
  final BuildContext context;
  bool isLoading = false;
  List<GetUserNotificationData> cricketdata = [];
  List<GetUserNotificationData> get todos => cricketdata;

  GetUserNotificationProvider(this.context);

  Future<void> getnotification() async {
    isLoading = true;
    notifyListeners();

    final response = await _service.Getnotification();

    response.fold((l) => null, (r) => cricketdata = r.cast<GetUserNotificationData>());

    isLoading = false;
    notifyListeners();

  }
}