import 'package:flutter/material.dart';
import 'package:flutter_fashion/Constants/text_styles.dart';

class ActionBar extends StatelessWidget {
  final String title;
  final bool hasBackArrow;
  final bool hasTitle;
  const ActionBar({Key? key, required this.title, required this.hasBackArrow, required this.hasTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: 42, right: 24, left: 24,),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if(hasBackArrow)
              Container(
                width: 38.0,
                height: 38.0,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(8.0)
                ),
                alignment: Alignment.center,
                child: Icon(Icons.arrow_back_ios_rounded,
                    size: 16,
                    color:Colors.white),
              ),
              if(hasTitle)
                Text(
                  title,
                  style: Constants.boldHeading,
                ),
            Container(
                width: 38.0,
                height: 38.0,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(8.0)
                ),
                alignment: Alignment.center,
                child: Text(
                  "0",
                  style: TextStyle(
                      fontSize: 16.0, fontWeight: FontWeight.w600, color: Colors.white),
                ))
          ],
        ));
  }
}
