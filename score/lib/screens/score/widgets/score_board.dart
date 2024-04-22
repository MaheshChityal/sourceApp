import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/match_data.dart';

class ScoreBoard extends StatelessWidget {
  const ScoreBoard({super.key});

  @override
  Widget build(BuildContext context) {
    MatchData matchData = Provider.of<MatchData>(context);

    // Calculate the total number of complete overs and the number of balls in the current over
    int completeOvers = matchData.totalBalls ~/ 6;
    int ballsThisOver = matchData.totalBalls % 6;

    // Calculate the current run rate
    double currentRunRate = matchData.totalBalls > 0 ? (matchData.totalRuns / (matchData.totalBalls / 6.0)) : 0.0;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${matchData.hostTeam} 1st inning',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                Text(
                  'CRR: ${currentRunRate.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${matchData.totalRuns} - ${matchData.totalWickets}',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                Text(
                  '($completeOvers.$ballsThisOver)',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                Text(
                  'R.R.: ${currentRunRate.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
