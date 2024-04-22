import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/match_data.dart';

class BattingScoreCard extends StatelessWidget {
  const BattingScoreCard({super.key});

  @override
  Widget build(BuildContext context) {
    MatchData matchData = Provider.of<MatchData>(context);  // This will make the widget listen to updates

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
            _buildBatsmanRow(context, matchData.onStrikePlayer, matchData.onStrikeBatsmanStats),
            _buildBatsmanRow(context, matchData.nonStrikePlayer, matchData.nonStrikeBatsmanStats),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Batsman', style: Theme.of(context).textTheme.bodyLarge),
        Text('R', style: Theme.of(context).textTheme.bodyLarge),
        Text('B', style: Theme.of(context).textTheme.bodyLarge),
        Text('4s', style: Theme.of(context).textTheme.bodyLarge),
        Text('6s', style: Theme.of(context).textTheme.bodyLarge),
        Text('SR', style: Theme.of(context).textTheme.bodyLarge),
      ],
    );
  }

  Widget _buildBatsmanRow(BuildContext context, String batsmanName, Map<String, int> stats) {
    double strikeRate = stats['balls']! > 0 ? (stats['runs']! / stats['balls']! * 100) : 0;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(batsmanName, style: Theme.of(context).textTheme.bodyMedium),
        Text('${stats['runs']}', style: Theme.of(context).textTheme.bodyMedium),
        Text('${stats['balls']}', style: Theme.of(context).textTheme.bodyMedium),
        Text('${stats['fours']}', style: Theme.of(context).textTheme.bodyMedium),
        Text('${stats['sixes']}', style: Theme.of(context).textTheme.bodyMedium),
        Text('${strikeRate.toStringAsFixed(2)}', style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }
}
