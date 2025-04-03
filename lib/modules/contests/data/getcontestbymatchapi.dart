import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:tempalteflutter/core/apis/apis.dart';
import 'package:tempalteflutter/core/errors%20copy/failures.dart';
import 'package:tempalteflutter/core/localstorage/localstorage.dart';
import 'package:tempalteflutter/modules/contests/domain/getcntestbymatchmodel.dart';

class GetContestByMatchapis {
  Future<Either<Failure, List<GetContestByMatchIdData>>> Getcontest() async {
    String link = "api/v1/contests/match/${await Storage().getItem('matchid')}";
    print(link);
    var response = await Apis.get(
      link,
    );
    if (response != Failure) {
      try {
        return Right(GetContestByMatchId.fromJson(response).data);
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
