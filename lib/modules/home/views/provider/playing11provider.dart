import 'package:flutter/material.dart';
import 'package:tempalteflutter/modules/home/domain/getplaying11.dart';

class Player11Provider with ChangeNotifier {
  List<Player11> _playing11Players = [];
  List<Player11> _allPlayers = [];

  List<Player11> get playing11Players => _playing11Players;
  List<Player11> get allPlayers => _allPlayers;

  void clearPlayers() {
    _playing11Players.clear();
    _allPlayers.clear();
    notifyListeners();
  }

  void addPlaying11Player(Player11 player) {
    _playing11Players.add(player);
    notifyListeners();
  }

  int countPlayersNotInPlaying11(List<String> todoIds) {
    int count = 0;
    for (var todoId in todoIds) {
      if (!_playing11Players.any((player) => player.playerId == todoId)) {
        count++;
      }
    }
    return count;
  }
}
