import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:tempalteflutter/core/Utils/constants.dart';
import 'package:tempalteflutter/core/apis/apis.dart';
import 'package:tempalteflutter/core/errors%20copy/failures.dart';
import 'package:tempalteflutter/core/localstorage/localstorage.dart';
import 'package:tempalteflutter/modules/createTeam/domain/getplayerdetailsmodel.dart';

class GetPlayerDetailsapis {
  Future<Either<Failure, List<GetPlayerDetailsData>>> Getplayer() async {
    String link =
        "competitions/${await Storage().getItem('cid')}/squads/${await Storage().getItem('matchid')}?token=${await Storage().getItem('apitoken')}";
    var response = await Apis.get2(
      link,
    );
    if (response != Failure) {
      try {
        return Right(GetPlayerDetailsModel.fromJson(response).response.squads);
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

  Future<Either<Failure, List<LastMatchPlayed>>> GetlastMatchPlayed() async {
    String link =
        "competitions/${await Storage().getItem('cid')}/squads/${await Storage().getItem('matchid')}?token=${await Storage().getItem('apitoken')}";
    var response = await Apis.get2(
      link,
    );
    if (response != Failure) {
      try {
        final List<GetPlayerDetailsData> squads =
            GetPlayerDetailsModel.fromJson(response).response.squads;
        final List<LastMatchPlayed> playedPlayers = [];

        for (final squad in squads) {
          playedPlayers.addAll(squad.lastMatchPlayed);
        }

        return Right(playedPlayers);
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
