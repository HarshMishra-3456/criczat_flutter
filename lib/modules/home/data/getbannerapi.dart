import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:tempalteflutter/core/apis/apis.dart';
import 'package:tempalteflutter/core/errors%20copy/failures.dart';
import 'package:tempalteflutter/modules/home/domain/getbannermodel.dart';


class GetBannerapis {
  Future<Either<Failure, List<BannerData>>> Getbanner() async {
    String link = "api/v1/banner";
    var response = await Apis.get(
      link,
    );
    if (response != Failure) {
      try {
        return Right(GetBanner.fromJson(response).banners);
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