import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:swipe_cards/swipe_cards.dart';
import 'package:vocab/cards/box.dart';
import 'package:vocab/widgets/painter/triangle.dart';
import 'package:vocab/cards/practice_card.dart';

class PracticeCardWidget extends StatefulWidget {
  final Box box;

  const PracticeCardWidget({
    required this.box,
    Key? key,
  }) : super(key: key);

  @override
  State createState() => _State();
}

class _State extends State<PracticeCardWidget> {
  @override
  Widget build(BuildContext context) {

    final k = widget.box.stacks.keys.toList();
    k.sort();
    final c = widget.box.stacks[k.first];

    final swipeItems = c?.map((c) => SwipeItem(content: c)).toList() ?? [];
    final matchEngine = MatchEngine(swipeItems: swipeItems);

    return SizedBox(
      height: 264,
      child: SwipeCards(
        matchEngine: matchEngine,
        onStackFinished: () {},
        itemBuilder: (context, idx) {
          return _card(context, swipeItems[idx].content);
        },
        fillSpace: true,
      ),
    );
  }

  Widget _card(BuildContext context, PracticeCard card) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: FlipCard(
        fill: Fill
            .fillBack, // Fill the back side of the card to make in the same size as the front.
        direction: FlipDirection.HORIZONTAL, // default
        front: _cardContent(context, text: card.front),
        back: _cardContent(context, text: card.back, front: false),
      ),
    );
  }

  Widget _cardContent(
    BuildContext context, {
    required String text,
    bool front = true,
  }) {
    final theme = Theme.of(context);
    return Card(
      color: front ? Colors.amber.shade800 : Colors.green.shade800,
      elevation: 0,
      child: Column(
        children: [
          Row(
            mainAxisAlignment:
                front ? MainAxisAlignment.end : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30,
                width: 30,
                child: CustomPaint(
                  painter:
                      TrianglePainter(color: theme.canvasColor, left: !front),
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.only(
              top: 70,
              bottom: 100,
              left: 100,
              right: 100,
            ),
            alignment: AlignmentDirectional.center,
            child: Text(
              text,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
