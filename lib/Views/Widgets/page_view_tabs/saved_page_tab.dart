import 'package:flutter/material.dart';
import 'package:flutter_fashion/Views/Widgets/action_bar.dart';

class SavedTab extends StatefulWidget {
  const SavedTab({Key? key}) : super(key: key);

  @override
  _SavedTabState createState() => _SavedTabState();
}

class _SavedTabState extends State<SavedTab> {

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 36),
          child: Center(
            child: Text("Savedpage"),
          ),
        ),
        ActionBar(title: "Saved", hasBackArrow: false, hasTitle: true)
      ],
    );
  }
}
