import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:tempalteflutter/core/apis/apis.dart';
import 'package:tempalteflutter/core/errors%20copy/failures.dart';
import 'package:tempalteflutter/modules/standingScreen/domain/completedmatchmodel.dart';

class GetCompleteMatchesapis {
  Future<Either<Failure, List<GetCompleteMatchesData>>> Getcompletematch() async {
    String link = "api/v1/completed-contest";
    print(link);
    var response = await Apis.get(
      link,
    );
    if (response != Failure) {
      try {
        return Right(GetCompleteMatches.fromJson(response).data);
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
