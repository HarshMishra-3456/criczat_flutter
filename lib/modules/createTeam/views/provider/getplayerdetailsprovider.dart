import 'package:flutter/material.dart';
import 'package:tempalteflutter/modules/createTeam/data/getplayerdetailsapi.dart';
import 'package:tempalteflutter/modules/createTeam/domain/getplayerdetailsmodel.dart';

class GetPlayerDetailsProvider extends ChangeNotifier {
  final _service = GetPlayerDetailsapis();
  final BuildContext context;
  bool isLoading = false;
  List<GetPlayerDetailsData> cricketdata = [];
  List<GetPlayerDetailsData> sortedCricketData = [];
  List<GetPlayerDetailsData> get todos => cricketdata;
  List<GetPlayerDetailsData> get sortedTodos => sortedCricketData;

  List<LastMatchPlayed> lastMatchPlayed = [];
  List<LastMatchPlayed> get getlastmatch => lastMatchPlayed;

  GetPlayerDetailsProvider(this.context);

  Future<void> getplayer() async {
    isLoading = true;
    notifyListeners();

    final response = await _service.Getplayer();

    response.fold((l) => null, (r) => cricketdata = r.cast<GetPlayerDetailsData>());
    sortedCricketData = List.from(cricketdata);

    isLoading = false;
    notifyListeners();
  }

  Future<void> getlastmatchplayed() async {
    isLoading = true;
    notifyListeners();

    final response = await _service.GetlastMatchPlayed();

    response.fold((l) => null, (r) => lastMatchPlayed = r.cast<LastMatchPlayed>());

    isLoading = false;
    notifyListeners();
  }

  void sortPlayersByFantasyPlayerRating(bool ascending) {
    sortedCricketData = cricketdata.map((team) {
      team.players.sort((a, b) {
        double ratingA = a.fantasyPlayerRating;
        double ratingB = b.fantasyPlayerRating;
        return ascending ? ratingA.compareTo(ratingB) : ratingB.compareTo(ratingA);
      });
      return team;
    }).toList();

    notifyListeners();
  }

}
