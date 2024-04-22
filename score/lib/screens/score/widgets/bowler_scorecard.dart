import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/match_data.dart';

class BowlingScoreCard extends StatelessWidget {
  const BowlingScoreCard({super.key});

  @override
  Widget build(BuildContext context) {
    final MatchData matchData = Provider.of<MatchData>(context);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            _buildHeader(context),
            Divider(),
            _buildBowlerStats(context, matchData.currentBowlerStats, matchData.openingBowler),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Bowler', style: Theme.of(context).textTheme.bodyLarge),
        Text('O', style: Theme.of(context).textTheme.bodyLarge),
        Text('M', style: Theme.of(context).textTheme.bodyLarge),
        Text('R', style: Theme.of(context).textTheme.bodyLarge),
        Text('W', style: Theme.of(context).textTheme.bodyLarge),
        Text('ER', style: Theme.of(context).textTheme.bodyLarge),
      ],
    );
  }

  Widget _buildBowlerStats(BuildContext context, Map<String, int> stats, String bowlerName) {
    int totalBalls = stats['balls']!;
    int overs = totalBalls ~/ 6;
    int extraBalls = totalBalls % 6;
    double economyRate = totalBalls > 0 ? (stats['runs']! / (overs + extraBalls / 10.0)) : 0.0;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(bowlerName, style: Theme.of(context).textTheme.bodyMedium),
        Text('$overs.${extraBalls}', style: Theme.of(context).textTheme.bodyMedium), // Overs
        Text('0', style: Theme.of(context).textTheme.bodyMedium),  // Maidens, needs logic for actual tracking
        Text('${stats['runs']}', style: Theme.of(context).textTheme.bodyMedium),  // Runs given
        Text('${stats['wickets']}', style: Theme.of(context).textTheme.bodyMedium), // Wickets taken
        Text('${economyRate.toStringAsFixed(2)}', style: Theme.of(context).textTheme.bodyMedium), // Economy rate
      ],
    );
  }
}
