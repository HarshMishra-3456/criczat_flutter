import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:tempalteflutter/core/apis/apis.dart';
import 'package:tempalteflutter/core/errors%20copy/failures.dart';
import 'package:tempalteflutter/modules/setting/domain/aboutusmodel.dart';


class GetAboutUsapis {
  Future<Either<Failure, List<AboutUsData>>> Getabout() async {
    String link = "api/v1/static/getAboutUs";
    var response = await Apis.get(
      link,
    );
    if (response != Failure) {
      try {
        return Right(AboutUs.fromJson(response).data);
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