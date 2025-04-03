import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:tempalteflutter/core/apis/apis.dart';
import 'package:tempalteflutter/core/errors%20copy/failures.dart';
import 'package:tempalteflutter/modules/setting/domain/getfantasyhelpmodel.dart';


class FantasyHelpapis {
  Future<Either<Failure, List<FantasyHelpData>>> Gethelp() async {
    String link = "api/v1/fantacy-help/getFantacySelfHelp";
    var response = await Apis.get(
      link,
    );
    if (response != Failure) {
      try {
        return Right(FantasyHelp.fromJson(response).data);
      } catch (e, st) {
        if (kDebugMode) {
          print(e);
          print(st);
        }
        print('ModelErrorFailure occurred');
        return Left(ModelErrorFailure());
      }
    }
    print('Other Failure occurred');
    return Left(response);
  }
}