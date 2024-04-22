import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:score/screens/score/widgets/runs_button.dart';
import '../../../providers/match_data.dart';

class RunsButtonContainer extends StatefulWidget {

  const RunsButtonContainer({super.key, });

  @override
  State<RunsButtonContainer> createState() => _RunsButtonContainerState();
}

class _RunsButtonContainerState extends State<RunsButtonContainer> {
  @override
  Widget build(BuildContext context) {

    void newBowlerDialog(BuildContext context) {
  TextEditingController bowlerNameController = TextEditingController();

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text("New Bowler"),
        content: TextField(
          controller: bowlerNameController,
          decoration: InputDecoration(
            hintText: "Enter new bowler's name"
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text("Cancel")
          ),
          TextButton(
            onPressed: () {
              if (bowlerNameController.text.isNotEmpty) {
                Provider.of<MatchData>(context, listen: false).setNewBowler(bowlerNameController.text);
                Navigator.of(context).pop();
              }
            },
            child: Text("Confirm")
          ),
        ],
      );
    },
  );
}

    var matchData = Provider.of<MatchData>(context, listen: false);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Wrap(
          children: [
            Row(
              children: [
                RunsButton(
                  runText: '0',
                  onPressed: () { matchData.addRun(0,);
                  if(matchData.shouldChangeBowler()){
                    newBowlerDialog(context);
                  }
                  }
                ),
                RunsButton(
                  runText: '1',
                  onPressed: () { matchData.addRun(1,);
                  if(matchData.shouldChangeBowler()){
                    newBowlerDialog(context);
                  }
                  }
                ),
                RunsButton(
                  runText: '2',
                  onPressed: () { matchData.addRun(2,);
                  if(matchData.shouldChangeBowler()){
                    newBowlerDialog(context);
                  }
                  }
                ),
                RunsButton(
                  runText: '3',
                  onPressed: () { matchData.addRun(3,);
                  if(matchData.shouldChangeBowler()){
                    newBowlerDialog(context);
                  }
                  }
                ),
                const SizedBox(
                  height: 10,
                ),
                RunsButton(
                  runText: '4',
                  onPressed: () { matchData.addRun(4,);
                  if(matchData.shouldChangeBowler()){
                    newBowlerDialog(context);
                  }
                  }
                ),
                RunsButton(
                  runText: '6',
                  onPressed: () { matchData.addRun(6,);
                  if(matchData.shouldChangeBowler()){
                    newBowlerDialog(context);
                  }
                  }
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
