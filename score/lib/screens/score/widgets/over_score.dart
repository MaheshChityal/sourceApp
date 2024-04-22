import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/match_data.dart';

class OverScore extends StatelessWidget {
  const OverScore({super.key});

  @override
  Widget build(BuildContext context) {
    final matchData = Provider.of<MatchData>(context);

    return Container(
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
        child: Row(
          children: [
            Text(
              'This over: ',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: matchData.thisOver.map((delivery) => Container(
                    margin: EdgeInsets.symmetric(horizontal: 4), // Spacing between deliveries
                    child: Text(
                      delivery,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  )).toList(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
