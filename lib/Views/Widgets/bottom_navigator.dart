import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'as firebase_auth;

import 'package:flutter_fashion/main.dart';


class CustomBottomNavigator extends StatefulWidget {

  final int tab;
  final Function(int) tabPressed;
  const CustomBottomNavigator({Key? key, required this.tab, required this.tabPressed}) : super(key: key);

  @override
  _CustomBottomNavigatorState createState() => _CustomBottomNavigatorState();
}

class _CustomBottomNavigatorState extends State<CustomBottomNavigator> {
  int _selectedTab=0;
  @override
  Widget build(BuildContext context) {
    _selectedTab=widget.tab;
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12), topRight: Radius.circular(12)),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                spreadRadius: 1.0,
                blurRadius: 30.0)
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CustomBottomNavigatorItem(
            icon: Icons.home_outlined,
            selected: _selectedTab==0?true:false,
            onPressed: () {
              widget.tabPressed(0);
            },
          ),
          CustomBottomNavigatorItem(
            icon: Icons.search,
            selected: _selectedTab==1?true:false,
            onPressed: () {
              widget.tabPressed(1);
            },
          ),
          CustomBottomNavigatorItem(
            icon: Icons.bookmark_border_rounded,
            selected: _selectedTab==2?true:false,
            onPressed: () {
              widget.tabPressed(2);
            },
          ),
          CustomBottomNavigatorItem(
            icon: Icons.logout_rounded,
            selected: _selectedTab==3?true:false,
            onPressed: () {
              firebase_auth.FirebaseAuth.instance.signOut();
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (builder) => MyApp()),
                      (route) => false);
            },
          ),
        ],
      ),
    );
  }
}


class CustomBottomNavigatorItem extends StatelessWidget {
  final IconData icon;
  final bool selected;
  final Function onPressed;
  CustomBottomNavigatorItem(
      {required this.icon, required this.selected, required this.onPressed,});
  @override
  Widget build(BuildContext context) {
    bool _selected = selected;
    return GestureDetector(
      onTap: () => onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 28),
        decoration: BoxDecoration(
            border: Border(
                top: BorderSide(
                    color: _selected
                        ? Theme.of(context).accentColor
                        : Colors.transparent,
                    width: 2.0))),
        child: Icon(
          icon,
          size: 24,
          color: _selected ? Theme.of(context).accentColor : Colors.black,
        ),
      ),
    );
  }
}
