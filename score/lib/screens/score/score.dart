import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/match_data.dart';
import '../../utility/colors.dart';
import 'widgets/batsman_scorecard.dart';
import 'widgets/bowler_scorecard.dart';
import 'widgets/over_score.dart';
import 'widgets/runbutton_container.dart';
import 'widgets/score_board.dart';

class ScoreScreen extends StatefulWidget {
  ScoreScreen({Key? key}) : super(key: key);

  @override
  State<ScoreScreen> createState() => _ScoreScreenState();
}

class _ScoreScreenState extends State<ScoreScreen> {
  bool _isWideChecked = false;

  bool _isNoBallChecked = false;

  bool _isByesChecked = false;

  bool _isLegByesChecked = false;

  bool _isWicketChecked = false;

  bool _isExtras = false;

  void resetCheckBoxes() {
    setState(() {
      _isWideChecked = false;
      _isNoBallChecked = false;
      _isByesChecked = false;
      _isLegByesChecked = false;
      _isWicketChecked = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final matchData = Provider.of<MatchData>(context);

    



    void showWicketDialog(BuildContext context, MatchData matchData) {
      TextEditingController newBatsmanController = TextEditingController();

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("New Batsman"),
            content: TextField(
              controller: newBatsmanController,
              decoration: InputDecoration(hintText: "Enter new batsman's name"),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text('Confirm'),
                onPressed: () {
                  Provider.of<MatchData>(context, listen: false)
                      .addWicket(); // Adding the wicket

                  // Replace the outgoing batsman with the new one
                  if (matchData.onStrikePlayer == matchData.nonStrikePlayer ||
                      matchData.onStrikePlayer.isNotEmpty) {
                    matchData.onStrikePlayer = newBatsmanController.text;
                  } else {
                    matchData.nonStrikePlayer = newBatsmanController.text;
                  }
                  resetCheckBoxes();
                  matchData.resetBatsmanStats();
                  Navigator.of(context).pop();
                  matchData.notifyListeners();
                },
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      backgroundColor: darkBgColor,
      appBar: AppBar(
        centerTitle: false,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )),
        backgroundColor: darkBgColor,
        title: Text(
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          "${matchData.hostTeam}  v/s ${matchData.visitorTeam}",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: [
          Icon(
            Icons.scoreboard_outlined,
            color: Colors.white,
            size: 28,
          ),
          SizedBox(
            width: 10,
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            //Score board
            ScoreBoard(),
            SizedBox(
              height: 10,
            ),
            //Batting score card
            BattingScoreCard(),
            SizedBox(
              height: 10,
            ),
            // Bowling score card
            BowlingScoreCard(),
            SizedBox(
              height: 10,
            ),
            // This over Score
            OverScore(),
            SizedBox(
              height: 10,
            ),

            //CheckBox
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: _isWideChecked,
                            onChanged: (bool? value) {
                              setState(() {
                                _isExtras = value!;
                                _isWideChecked = value;
                                if (_isWideChecked) {
                                  _isNoBallChecked = false;
                                  _isByesChecked = false;
                                  _isLegByesChecked = false;
                                  Provider.of<MatchData>(context, listen: false)
                                      .addWide(1);
                                }
                              });
                            },
                          ),
                          Text('Wide'),
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(
                            value: _isNoBallChecked,
                            onChanged: (bool? value) {
                              setState(() {
                                _isExtras = value!;
                                _isNoBallChecked = value!;
                                if (_isNoBallChecked) {
                                  _isWideChecked = false;
                                  Provider.of<MatchData>(context, listen: false)
                                      .addNoBall(1);
                                }
                              });
                            },
                          ),
                          Text('No ball'),
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(
                            value: _isByesChecked,
                            onChanged: (bool? value) {
                              setState(() {
                                _isByesChecked = value!;
                                if (_isByesChecked) {
                                  _isWideChecked = false;
                                  _isLegByesChecked = false;
                                  Provider.of<MatchData>(context, listen: false)
                                      .addBye(1);
                                }
                              });
                            },
                          ),
                          Text('Byes'),
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(
                            value: _isLegByesChecked,
                            onChanged: (bool? value) {
                              setState(() {
                                _isLegByesChecked = value!;
                                if (_isLegByesChecked) {
                                  _isWideChecked = false;
                                  _isByesChecked = false;
                                  Provider.of<MatchData>(context, listen: false)
                                      .addLegBye(1);
                                }
                              });
                            },
                          ),
                          Text('Leg Byes'),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: _isWicketChecked,
                            onChanged: (bool? value) {
                              setState(() {
                                _isWicketChecked = value!;
                                if (_isWicketChecked) {
                                  // Show the dialog to enter new batsman's name
                                  showWicketDialog(
                                      context,
                                      Provider.of<MatchData>(context,
                                          listen: false));
                                }
                              });
                            },
                          ),
                          Text('Wicket'),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 10, bottom: 10),
                        child: Row(
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                backgroundColor: greenColor,
                              ),
                              onPressed: () {},
                              child: Text(
                                'Retire',
                                style:
                                    TextStyle(color: blackColor, fontSize: 16),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                backgroundColor: greenColor,
                              ),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Undo Confirmation'),
                                      content: Text(
                                          'Are you sure you want to undo the last action?'),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context)
                                                .pop(); // Close the dialog
                                          },
                                          child: Text('Cancel'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context)
                                                .pop(); // Close the dialog
                                            Provider.of<MatchData>(context,
                                                    listen: false)
                                                .undoLastAction();
                                          },
                                          child: Text('Undo'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: Text(
                                'Undo',
                                style:
                                    TextStyle(color: blackColor, fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(
              height: 10,
            ),

            SizedBox(
              width: 10,
            ),
            RunsButtonContainer(
            ),
          ],
        ),
      ),
    );
  }
}
