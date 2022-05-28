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
  int _currentItem = 0;

  @override
  Widget build(BuildContext context) {
    final k = widget.box.stacks.keys.toList();
    k.sort();
    final c = widget.box.stacks[k.first];

    final swipeItems = c?.map((c) => SwipeItem(content: c)).toList() ?? [];
    final matchEngine = MatchEngine(swipeItems: swipeItems);

    return SizedBox(
      height: 300,
      child: SwipeCards(
        matchEngine: matchEngine,
        fillSpace: true,
        itemBuilder: (context, idx) {
          return _card(context, swipeItems[idx].content,
              fade: idx != _currentItem);
        },
        onStackFinished: () {},
        itemChanged: (item, index) {
          _currentItem = index;
        },
      ),
    );
  }

  Widget _card(BuildContext context, PracticeCard card, {bool fade = false}) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: FlipCard(
        fill: Fill
            .fillBack, // Fill the back side of the card to make in the same size as the front.
        direction: FlipDirection.HORIZONTAL, // default
        front: _cardContent(context, text: card.front, fade: fade),
        back: _cardContent(context, text: card.back, fade: fade, front: false),
      ),
    );
  }

  Widget _cardContent(
    BuildContext context, {
    required String text,
    bool front = true,
    bool fade = false,
  }) {
    final theme = Theme.of(context);
    final tt = theme.textTheme;
    final alpha = fade ? 100 : 255;

    return Card(
      color: (front ? Colors.amber.shade800 : Colors.green.shade800)
          .withAlpha(alpha),
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
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(
                top: 0,
                bottom: 30,
                left: 30,
                right: 30,
              ),
              alignment: AlignmentDirectional.center,
              child: Text(
                text,
                style: tt.caption?.copyWith(
                  color: Colors.white.withAlpha(alpha),
                  fontSize: 18,
                ),
                overflow: TextOverflow.fade,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
