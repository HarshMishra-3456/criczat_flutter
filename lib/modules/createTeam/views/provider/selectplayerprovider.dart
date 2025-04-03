import 'package:flutter/material.dart';
import 'package:tempalteflutter/core/Utils/authutilities.dart';
import 'package:tempalteflutter/core/Utils/constants.dart';
import 'package:tempalteflutter/modules/createTeam/domain/selectplayermodel.dart';

class SelectedPlayersProvider extends ChangeNotifier {
  List<SelectPlayer> _selectedPlayers = [];
  List<SelectPlayer> get selectedPlayers => _selectedPlayers;
  int _wkCount = 0;
  int _batCount = 0;
  int _allCount = 0;
  int _bowlCount = 0;
  double _creditscore = 100.0;

  int get wkCount => _wkCount;
  int get batCount => _batCount;
  int get allCount => _allCount;
  int get bowlCount => _bowlCount;
  double get creditscore => _creditscore;

  bool areCategoriesValid() {
    return _wkCount >= 1 && _batCount >= 1 && _allCount >= 1 && _bowlCount >= 1;
  }

  bool isTeamComplete() {
    return _selectedPlayers.length == 11;
  }

  bool isTeamSelectionValid() {
    return areCategoriesValid() && isTeamComplete();
  }

  void clearPlayers() {
    _selectedPlayers.clear();
    _creditscore = 100.0;
    _wkCount = 0;
    _batCount = 0;
    _allCount = 0;
    _bowlCount = 0;
    notifyListeners();
  }

  void addPlayer(SelectPlayer player) {
    if (_selectedPlayers
        .any((existingPlayer) => existingPlayer.pid == player.pid)) {
      _selectedPlayers
          .removeWhere((existingPlayer) => existingPlayer.pid == player.pid);
      Authutilities.playerlenght = _selectedPlayers.length;
      _creditscore += double.parse(player.fantasyPlayerRating);
      notifyListeners();
    } else {
      if (player.playingRole == 'wk' &&
          _selectedPlayers
                  .where((player) => player.playingRole == 'wk')
                  .length >=
              8) {
        constToast('Maximum Wicket-keeper players selected');
        return;
      }
      if (player.playingRole == 'bat' &&
          _selectedPlayers
                  .where((player) => player.playingRole == 'bat')
                  .length >=
              8) {
        constToast('Maximum Batsman players selected');
        return;
      }
      if (player.playingRole == 'all' &&
          _selectedPlayers
                  .where((player) => player.playingRole == 'all')
                  .length >=
              8) {
        constToast('Maximum All-Rounder players selected');
        return;
      }
      if (player.playingRole == 'bowl' &&
          _selectedPlayers
                  .where((player) => player.playingRole == 'bowl')
                  .length >=
              8) {
        constToast('Maximum Bowler players selected');
        return;
      }

      if (_selectedPlayers.length < 11) {
        _selectedPlayers.add(player);
        Authutilities.playerlenght = _selectedPlayers.length;
        // _selectedPlayers.forEach((player) {
        //   print(player.shortName);
        // });

        _wkCount = _selectedPlayers
            .where((player) => player.playingRole == 'wk')
            .length;
        _batCount = _selectedPlayers
            .where((player) => player.playingRole == 'bat')
            .length;
        _allCount = _selectedPlayers
            .where((player) => player.playingRole == 'all')
            .length;
        _bowlCount = _selectedPlayers
            .where((player) => player.playingRole == 'bowl')
            .length;

        _creditscore -= double.parse(player.fantasyPlayerRating);
        notifyListeners();
      } else {
        constToast('Team Completed');
      }
    }
  }
}
