import 'package:collection/collection.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swipe_cards/swipe_cards.dart';
import 'package:vocab/cards/box.dart';
import 'package:vocab/widgets/painter/triangle.dart';
import 'package:vocab/cards/practice_card.dart';

class PracticeCardWidget extends StatefulWidget {
  final VoidCallback save;

  const PracticeCardWidget({
    required this.save,
    Key? key,
  }) : super(key: key);

  @override
  State createState() => _State();
}

class _State extends State<PracticeCardWidget> {
  int? _currentIndex;
  int? _count;

  @override
  Widget build(BuildContext context) {
    final box = Provider.of<Box>(context);

    if (!box.hasPracticeCards) {
      return _noPracticeCards(context, box);
    } else {
      return Column(
        children: [
          _progressCounter(context),
          _swipeCard(context),
        ],
      );
    }
  }

  Widget _progressCounter(BuildContext context) {
    final th = Theme.of(context).textTheme;

    if (_currentIndex != null && _count != null) {
      return Padding(
        padding: const EdgeInsets.only(top: 10, left: 30, right: 30),
        child: Align(
          alignment: AlignmentDirectional.topStart,
          child: Text(
            "Card ${(_currentIndex ?? 0) + 1} of $_count:",
            style: th.caption,
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  void _reset() {
    setState(() {
      _currentIndex = null;
      _count = null;
      _matchEngine = null;
      _swipeItems = null;
      _swipeCardsKey = GlobalKey();
    });
  }

  void _onStackFinished(Box box) {
    _reset();
  }

  Widget _noPracticeCards(BuildContext context, Box box) {
    if (box.totalCounts().values.sum == 0) {
      return _noCards();
    } else {
      // show reset practice controls
      return _allDone(context);
    }
  }

  Widget _noCards() => const Padding(
        padding: EdgeInsets.all(30),
        child: Text("No cards yet! Add some to start practicing."),
      );

  Widget _allDone(BuildContext context) {
    final th = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(30),
      child: Text(
        "Well done! All cards finished.",
        style: th.titleMedium,
      ),
    );
  }

  List<SwipeItem>? _swipeItems;
  MatchEngine? _matchEngine;
  GlobalKey? _swipeCardsKey;

  Widget _swipeCard(BuildContext context) {
    final box = Provider.of<Box>(context);

    if (!box.hasPracticeCards) {
      return _noCards();
    } else {
      if (_swipeItems == null || !box.hasAdvancedCards) {
        _reset();

        final all = box.practiceStack.allCards();

        _currentIndex = 0;
        _count = all.length;

        _swipeItems = all
            .map((card) => SwipeItem(
                  content: card,
                  likeAction: () {
                    box.advanceTopCard();
                    widget.save();
                  },
                  nopeAction: () {
                    box.lowerTopCard();
                    widget.save();
                  },
                ))
            .toList();

        _matchEngine = MatchEngine(swipeItems: _swipeItems);
      }

      return SizedBox(
        height: 300,
        child: SwipeCards(
          key: _swipeCardsKey,
          matchEngine: _matchEngine!,
          fillSpace: true,
          itemBuilder: (context, idx) {
            return _card(context, _swipeItems![idx].content,
                fade: idx != _currentIndex);
          },
          onStackFinished: () {
            _onStackFinished(box);
          },
          itemChanged: (item, index) {
            _currentIndex = index;
          },
        ),
      );
    }
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
