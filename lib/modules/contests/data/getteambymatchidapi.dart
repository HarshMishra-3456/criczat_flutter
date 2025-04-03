import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:tempalteflutter/core/apis/apis.dart';
import 'package:tempalteflutter/core/errors%20copy/failures.dart';
import 'package:tempalteflutter/core/localstorage/localstorage.dart';
import 'package:tempalteflutter/modules/contests/domain/getteambymatchid.dart';


class GetTeamByMatchIdapis {
  Future<Either<Failure, GetTeamByMatchId>> Getteam() async {
    String link = "api/v1/user/teams/by/match/${await Storage().getItem('matchid')}";

    var response = await Apis.get(
      link,
    );
    if (response != Failure) {
      try {
        return Right(GetTeamByMatchId.fromJson(response));
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