import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:tempalteflutter/core/apis/apis.dart';
import 'package:tempalteflutter/core/errors%20copy/failures.dart';
import 'package:tempalteflutter/core/localstorage/localstorage.dart';
import 'package:tempalteflutter/modules/standingScreen/domain/getfantasyplayerpoint.dart';

class GetFantasyPlayerPointapis {
  Future<Either<Failure, GetFantasyPlayerPoint>> Getlivematch() async {
    String link = "matches/${await Storage().getItem('livematchid')}/newpoint2?token=${await Storage().getItem('apitoken')}";
    print(link);
    var response = await Apis.get2(
      link,
    );
    if (response != Failure) {
      try {
        return Right(GetFantasyPlayerPoint.fromJson(response));
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
