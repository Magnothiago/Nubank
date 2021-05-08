import 'package:flutter/material.dart';
import 'package:nubank/pages/home/widgets/card_app.dart';
import 'package:nubank/pages/home/widgets/my_app_bar.dart';
import 'package:nubank/pages/home/widgets/page_view_app.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _ShowMenu;
  int _currentIndex;
  @override
  void initState() {
    super.initState();
    _ShowMenu = false;
    _currentIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    double _scrennHeigth = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.purple,
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          MyAppBar(
            showMenu: _ShowMenu,
            onTap: () {
              setState(() {
                _ShowMenu = !_ShowMenu;
              });
            },
          ),
          PageViewApp(
            top: _scrennHeigth * 0.24,
            onChanged: (index) {
              setState(() {
                _currentIndex = index;
                ;
              });
            },
          )
        ],
      ),
    );
  }
}
