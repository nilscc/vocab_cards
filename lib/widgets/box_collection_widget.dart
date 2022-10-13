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
                    onLongPress: () => _confirmDelete(context, e),
                  )),
            )
            .toList(),
      );
    }
  }

  void _confirmDelete(BuildContext context, Box box) {
    final bc = Provider.of<BoxCollection>(context, listen: false);

    String t;

    final c = box.count();
    if (c == 0) {
      t = 'The box is currently empty.';
    } else {
      t = 'All $c cards will be deleted and all learning progress lost.';
    }

    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('Delete Box "${box.name}"?'),
              content: Text(t),
              actions: [
                // Discard button
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Discard'),
                ),
                // Delete button
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.red),
                  ),
                  child: const Text("Delete"),
                  onPressed: () {
                    Navigator.of(context).pop();
                    bc.remove(box);
                    bc.save(); // async, but drop to background
                  },
                ),
              ],
            ));
  }
}
