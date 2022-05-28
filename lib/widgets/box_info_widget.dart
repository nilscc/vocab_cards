import 'package:flutter/material.dart';
import 'package:vocab/cards/box.dart';

class BoxInfoWidget extends StatelessWidget {
  final Box box;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  const BoxInfoWidget({
    required this.box,
    this.onTap,
    this.onLongPress,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // get text styles
    final th = Theme.of(context);
    final tt = th.textTheme;

    // lookup box counts
    final counts = box.counts();
    counts.removeWhere((key, value) => value <= 0);

    // sort stack levels
    final stackKeys = counts.keys.toList();
    stackKeys.sort();

    // format level counts into printable string
    final formatedCounts = stackKeys.map((i) => 'Level $i: ${counts[i]}');

    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Card(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                box.name,
                style: tt.titleLarge,
              ),
              const Divider(),
              if (counts.isNotEmpty)
                Text('Cards: ${formatedCounts.join(", ")}', style: tt.caption)
              else
                Text(
                  'No cards yet.',
                  style: tt.caption,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
