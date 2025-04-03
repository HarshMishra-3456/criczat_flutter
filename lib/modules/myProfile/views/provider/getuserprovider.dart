import 'package:flutter/material.dart';
import 'package:tempalteflutter/core/localstorage/localstorage.dart';
import 'package:tempalteflutter/modules/myProfile/data/getuserapi.dart';
import 'package:tempalteflutter/modules/myProfile/domain/getusermodel.dart';


class GetUserDataProvider extends ChangeNotifier {
  final _service = GetUserDataapis();
  final BuildContext context;
  bool isLoading = false;
  UserDetails? cricketdata;
  UserDetails? get todos => cricketdata;

  GetUserDataProvider(this.context);

  Future<void> getuser() async {
    isLoading = true;
    notifyListeners();

    final response = await _service.Getuser();

    response.fold((l) => null, (r) async{
      cricketdata = r;
      await Storage().setItem('apitoken', cricketdata?.ApiToken);
      print(await Storage().getItem('apitoken'));
    });

    isLoading = false;
    notifyListeners();

  }
}