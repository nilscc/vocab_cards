import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vocab/cards/box.dart';
import 'package:vocab/cards/box_collection.dart';
import 'package:vocab/widgets/box_info_widget.dart';

class BoxCollectionWidget extends StatelessWidget {
  final ValueChanged<Box>? onBoxSelected;

  const BoxCollectionWidget({
    this.onBoxSelected,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bc = Provider.of<BoxCollection>(context);

    if (bc.boxes.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(20),
        child: const Text("No boxes yet."),
      );
    } else {
      return ListView(
        children: bc.boxes
            .map(
              (e) => ChangeNotifierProvider.value(
                  value: e,
                  child: BoxInfoWidget(
                    onTap: () => onBoxSelected?.call(e),
                  )),
            )
            .toList(),
      );
    }
  }
}
