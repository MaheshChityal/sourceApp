import 'package:flutter/material.dart';

class MatchData extends ChangeNotifier {
  String hostTeam = '';
  String visitorTeam = '';
  String onStrikePlayer = '';
  String nonStrikePlayer = '';
  String openingBowler = '';
  List<String> thisOver = [];

  // Initialize scores and counts
  int totalRuns = 0;
  int totalWickets = 0;
  int totalOvers = 0;
  int totalBalls = 0;

  // Player-specific data
  Map<String, int> onStrikeBatsmanStats = {
    'runs': 0,
    'balls': 0,
    'fours': 0,
    'sixes': 0,
  };
  Map<String, int> nonStrikeBatsmanStats = {
    'runs': 0,
    'balls': 0,
    'fours': 0,
    'sixes': 0,
  };
  Map<String, int> currentBowlerStats = {
    'balls': 0,
    'runs': 0,
    'wickets': 0,
    'overs': 0,
  };

  void setTeams(String host, String visitor, String strikePlayer,
      String nonStrikeBatsman, String openBowler) {
    hostTeam = host;
    visitorTeam = visitor;
    onStrikePlayer = strikePlayer;
    nonStrikePlayer = nonStrikeBatsman;
    openingBowler = openBowler;

    notifyListeners();
  }

  void resetBatsmanStats() {
    onStrikeBatsmanStats = {
      'runs': 0,
      'balls': 0,
      'fours': 0,
      'sixes': 0,
    };
  }

  void setNewBowler(String newBowler) {
  openingBowler = newBowler;
  currentBowlerStats = {
    'balls': 0,
    'runs': 0,
    'wickets': 0,
    'overs': 0,
  };
  notifyListeners();
}

bool shouldChangeBowler() {
  return currentBowlerStats['balls']! % 6 == 0 && currentBowlerStats['balls'] != 0;
}


  void changeStrike() {
    String temp = onStrikePlayer;
    onStrikePlayer = nonStrikePlayer;
    nonStrikePlayer = temp;

    // Swap stats as well for immediate updates in UI
    var tempStats = Map<String, int>.from(onStrikeBatsmanStats);
    onStrikeBatsmanStats = nonStrikeBatsmanStats;
    nonStrikeBatsmanStats = tempStats;

    notifyListeners();
  }

  void addRun(int runs, {bool changeStrike = false}) {
  totalRuns += runs;
  totalBalls += 1;

  // Update batsman stats
  if (onStrikePlayer.isNotEmpty) {
    onStrikeBatsmanStats['runs'] = (onStrikeBatsmanStats['runs'] ?? 0) + runs;
    onStrikeBatsmanStats['balls'] = (onStrikeBatsmanStats['balls'] ?? 0) + 1;
    if (runs == 4) {
      onStrikeBatsmanStats['fours'] = (onStrikeBatsmanStats['fours'] ?? 0) + 1;
    } else if (runs == 6) {
      onStrikeBatsmanStats['sixes'] = (onStrikeBatsmanStats['sixes'] ?? 0) + 1;
    }
  }

  if (openingBowler.isNotEmpty) {
    currentBowlerStats['runs'] = (currentBowlerStats['runs'] ?? 0) + runs;
    currentBowlerStats['balls'] = (currentBowlerStats['balls'] ?? 0) + 1;
    if (totalBalls % 6 == 0) {
      currentBowlerStats['overs'] = (currentBowlerStats['overs'] ?? 0) + 1;
      if (changeStrike) {
        changeStrike; 
      }
      thisOver.clear(); 
      
    }
  }

  thisOver.add(runs.toString());
  notifyListeners();
}


  void addWicket() {
    totalWickets += 1;
    currentBowlerStats['wickets'] = (currentBowlerStats['wickets'] ?? 0) + 1;
    thisOver.add('W');  
    notifyListeners();
  }

  void addWide(int runs) {
    totalRuns += runs;
    thisOver.add('WD ' + runs.toString());
    notifyListeners();
  }

  void addNoBall(int runs) {
    totalRuns += runs;
    thisOver.add('NB ' + runs.toString());
    notifyListeners();
  }

  void addBye(int runs) {
    totalRuns += runs;
    thisOver.add('B ' + runs.toString());
    notifyListeners();
  }

  void addLegBye(int runs) {
    totalRuns += runs;
    thisOver.add('LB ' + runs.toString());
    notifyListeners();
  }

  void undoLastAction() {
    if (thisOver.isNotEmpty) {
      String lastAction = thisOver.removeLast();
      if (lastAction.startsWith('W')) {
        totalWickets -= 1;
      } else {
        int runs = int.parse(lastAction.replaceAll(RegExp(r'[^\d]'), ''));
        totalRuns -= runs;
      }
      notifyListeners();
    }
  }
}
