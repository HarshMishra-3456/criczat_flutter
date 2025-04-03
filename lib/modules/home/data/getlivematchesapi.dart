import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:tempalteflutter/core/apis/apis.dart';
import 'package:tempalteflutter/core/errors%20copy/failures.dart';
import 'package:tempalteflutter/modules/home/domain/getlivematchesmodel.dart';


class GetLiveMatchapis {
  Future<Either<Failure, List<LiveItem>>> Getlive() async {
    String link = "api/v1/current/matches?status=3";
    var response = await Apis.get(
      link,
    );
    if (response != Failure) {
      try {
        return Right(GetLiveMatch.fromJson(response).matchIdInfo.items);
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