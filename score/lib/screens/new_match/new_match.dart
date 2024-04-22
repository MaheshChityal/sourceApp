import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:score/screens/score/score.dart';
import 'package:score/utility/colors.dart';
import 'package:score/utility/regex.dart';

import '../../providers/match_data.dart'; // Import your MatchData model

enum Teams { hostTeam, visitorTeam }

class NewMatchScreen extends StatefulWidget {
  NewMatchScreen({Key? key}) : super(key: key);

  @override
  State<NewMatchScreen> createState() => _NewMatchScreenState();
}

class _NewMatchScreenState extends State<NewMatchScreen> {
  Teams? _teamWonToss;
  Teams? _optedTo;
  final TextEditingController _hostTeamController = TextEditingController();
  final TextEditingController _visitorTeamController = TextEditingController();
  final TextEditingController _oversController = TextEditingController();
  final TextEditingController _teamPlayersController = TextEditingController();
  final TextEditingController _onStrikeController = TextEditingController();
  final TextEditingController _nonStrikeController = TextEditingController();
  final TextEditingController _openingBowlerController =
      TextEditingController();

  bool _hostTeamError = false;
  bool _visitTeamError = false;
  bool _oversError = false;
  bool _teamPlayersError = false;
  bool _onStrikeError = false;
  bool _nonStrikeError = false;
  bool _openingBowlerError = false;

  void _showAddPlayersModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Add Players',
                    style: TextStyle(fontSize: 20.0),
                  ),
                  SizedBox(height: 16.0),
                  TextField(
                    maxLines: 1,
                    onChanged: (String text) {
                      _onStrikeError =
                          !RegExp(CommonPattern.text_regex).hasMatch(text);
                      setState(() {});
                    },
                    controller: _onStrikeController,
                    decoration: InputDecoration(
                      labelText: 'On Strike Player',
                      errorText: _onStrikeError
                          ? "Please enter On-Strike Player "
                          : null,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  TextField(
                    onChanged: (String text) {
                      _nonStrikeError =
                          !RegExp(CommonPattern.text_regex).hasMatch(text);
                      setState(() {});
                    },
                    controller: _nonStrikeController,
                    decoration: InputDecoration(
                      labelText: 'Non-Strike Player',
                      errorText: _nonStrikeError
                          ? "Please enter non-strike player name."
                          : null,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  TextField(
                    onChanged: (String text) {
                      _openingBowlerError =
                          !RegExp(CommonPattern.text_regex).hasMatch(text);
                      setState(() {});
                    },
                    controller: _openingBowlerController,
                    decoration: InputDecoration(
                      labelText: 'Opening Bowler',
                      errorText: _openingBowlerError
                          ? "Please enter opening bowler name."
                          : null,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      backgroundColor: greenColor,
                    ),
                    onPressed: () {
                      // Store the data or perform any other action
                      String onStrikePlayer = _onStrikeController.text;
                      String nonStrikePlayer = _nonStrikeController.text;
                      String openingBowler = _openingBowlerController.text;
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Save',
                      style: TextStyle(color: blackColor),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: darkBgColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Teams',
                  style: TextStyle(fontSize: 20, color: greenColor),
                ),
                SizedBox(height: 5),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        TextField(
                          controller: _hostTeamController,
                          onChanged: (String text) {
                            _hostTeamError = !RegExp(CommonPattern.text_regex)
                                .hasMatch(text);
                            setState(() {});
                          },
                          decoration: InputDecoration(
                            hintText: 'Host Team',
                            errorText: _hostTeamError
                                ? "Please enter a host team name."
                                : null,
                          ),
                        ),
                        TextField(
                          controller: _visitorTeamController,
                          onChanged: (String text) {
                            _visitTeamError = !RegExp(CommonPattern.text_regex)
                                .hasMatch(text);
                            setState(() {});
                          },
                          decoration: InputDecoration(
                            hintText: 'Visitor Team',
                            errorText: _visitTeamError
                                ? "Please enter a visitor team name."
                                : null,
                          ),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      'Toss won by?',
                      style: TextStyle(fontSize: 20, color: greenColor),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      RadioListTile<Teams>(
                        title: Text(_hostTeamController.text.isEmpty
                            ? 'Host Team'
                            : _hostTeamController.text),
                        value: Teams.hostTeam,
                        groupValue: _teamWonToss,
                        onChanged: (Teams? value) {
                          setState(() {
                            _teamWonToss = value;
                          });
                        },
                      ),
                      RadioListTile<Teams>(
                        title: Text(_visitorTeamController.text.isEmpty
                            ? 'Visitor Team'
                            : _visitorTeamController.text),
                        value: Teams.visitorTeam,
                        groupValue: _teamWonToss,
                        onChanged: (Teams? value) {
                          setState(() {
                            _teamWonToss = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Opted to?',
                  style: TextStyle(fontSize: 20, color: greenColor),
                ),
                SizedBox(height: 5),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      RadioListTile<Teams>(
                        title: Text('Bat'),
                        value: Teams.hostTeam,
                        groupValue: _optedTo,
                        onChanged: (Teams? value) {
                          setState(() {
                            _optedTo = value;
                          });
                        },
                      ),
                      RadioListTile<Teams>(
                        title: Text('Ball'),
                        value: Teams.visitorTeam,
                        groupValue: _optedTo,
                        onChanged: (Teams? value) {
                          setState(() {
                            _optedTo = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Overs?',
                  style: TextStyle(fontSize: 20, color: greenColor),
                ),
                SizedBox(height: 5),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _oversController,
                      onChanged: (String text) {
                        _oversError =
                            !RegExp(CommonPattern.numberRegex).hasMatch(text);
                        setState(() {});
                      },
                      decoration: InputDecoration(
                        hintText: '10',
                        errorText:
                            _hostTeamError ? "Please enter overs." : null,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Team player?',
                  style: TextStyle(fontSize: 20, color: greenColor),
                ),
                SizedBox(height: 5),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _teamPlayersController,
                      onChanged: (String text) {
                        _teamPlayersError =
                            !RegExp(CommonPattern.numberRegex).hasMatch(text);
                        setState(() {});
                      },
                      decoration: InputDecoration(
                        hintText: '11',
                        errorText: _teamPlayersError
                            ? "Please enter team players."
                            : null,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Consumer<MatchData>(
                  builder: (context, matchData, child) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            backgroundColor: greenColor,
                          ),
                          onPressed: () {
                            _showAddPlayersModalBottomSheet(context);
                          },
                          child: Text(
                            'Add players name',
                            style: TextStyle(color: blackColor, fontSize: 20),
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            backgroundColor: greenColor,
                          ),
                          onPressed: () {
                            _hostTeamError = !RegExp(CommonPattern.text_regex)
                                .hasMatch(_hostTeamController.text);
                            _visitTeamError = !RegExp(CommonPattern.text_regex)
                                .hasMatch(_visitorTeamController.text);
                            _oversError = !RegExp(CommonPattern.text_regex)
                                .hasMatch(_oversController.text);
                            _teamPlayersError =
                                !RegExp(CommonPattern.text_regex)
                                    .hasMatch(_teamPlayersController.text);

                            if (_teamWonToss == Teams.hostTeam &&
                                _optedTo == Teams.hostTeam) {
                              matchData.setTeams(
                                _hostTeamController.text,
                                _visitorTeamController.text,
                                _onStrikeController.text,
                                _nonStrikeController.text,
                                _openingBowlerController.text,
                                
                              );
                            } else {
                              matchData.setTeams(
                                _visitorTeamController.text,
                                _hostTeamController.text,
                                _onStrikeController.text,
                                _nonStrikeController.text,
                                _openingBowlerController.text,
                              );
                            }
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: ((context) => ScoreScreen()),
                              ),
                            );
                          },
                          child: Text(
                            'Start match',
                            style: TextStyle(color: blackColor, fontSize: 20),
                          ),
                        ),
                      ],
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
