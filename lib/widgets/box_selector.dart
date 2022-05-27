import 'package:flutter/material.dart';

class BoxSelectorWidget extends StatelessWidget {
  const BoxSelectorWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 50,
      width: 50,
      child: Card(child: Text("Boxes!")),
    );
  }
}
