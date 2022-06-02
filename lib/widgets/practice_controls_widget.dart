import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vocab/cards/box.dart';

class PracticeControlsWidget extends StatelessWidget {
  const PracticeControlsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final box = Provider.of<Box>(context, listen: false);
    if (box.hasPracticeCards || box.hasAdvancedCards) {
      return _controls(context);
    } else {
      return Container();
    }
  }

  Widget _controls(BuildContext context) {
    final th = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Controls",
            style: th.titleMedium,
          ),
          const Divider(),
          Text(
            "Use the following buttons to reset or shuffle the current training "
            "session. Shuffling will maintain all levels but randomize the "
            "order of cards in each level.",
            style: th.caption,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    child: Text("Reset"),
                  ),
                  onPressed: () {
                    final b = Provider.of<Box>(context, listen: false);
                    b.resetPractice();
                  },
                ),
                TextButton(
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    child: Text("Shuffle"),
                  ),
                  onPressed: () {
                    final b = Provider.of<Box>(context, listen: false);
                    b.resetPractice();
                    b.shuffle();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
