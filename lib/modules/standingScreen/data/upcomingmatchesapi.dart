import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:tempalteflutter/core/apis/apis.dart';
import 'package:tempalteflutter/core/errors%20copy/failures.dart';
import 'package:tempalteflutter/modules/standingScreen/domain/upcomingmatchmodel.dart';

class GetUpcomingMatchesapis {
  Future<Either<Failure, List<GetUpcomingMatchesData>>> Getupcomingmatch() async {
    String link = "api/v1/upcoming-contests";
    var response = await Apis.get(
      link,
    );
    if (response != Failure) {
      try {
        return Right(GetUpcomingMatches.fromJson(response).data);
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
