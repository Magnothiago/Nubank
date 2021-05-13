import 'package:flutter/material.dart';
import 'package:nubank/pages/home/widgets/my_app_bar.dart';
import 'package:nubank/pages/home/widgets/my_dots_app.dart';
import 'package:nubank/pages/home/widgets/page_view_app.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _ShowMenu;
  int _currentIndex;
  double _yPosition;

  @override
  void initState() {
    super.initState();
    _ShowMenu = false;
    _currentIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    double _scrennHeigth = MediaQuery.of(context).size.height;

    if (_yPosition == null) {
      _yPosition = _scrennHeigth * .24;
    }

    var white = Colors.white;
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
                _yPosition =
                    _ShowMenu ? _scrennHeigth * .75 : _scrennHeigth * .24;
              });
            },
          ),
          PageViewApp(
            showMenu: _ShowMenu,
            onPanUpdate: (details) {
              double positionLimit = _scrennHeigth * .75;
              double positionLimitTop = _scrennHeigth * .24;
              double midlePosition = (positionLimitTop - positionLimit) / 2;
              setState(() {
                _yPosition += details.delta.dy;

                _yPosition = _yPosition < positionLimitTop
                    ? positionLimitTop
                    : _yPosition;

                _yPosition =
                    _yPosition > positionLimit ? positionLimit : _yPosition;

                if (_yPosition != positionLimit && details.delta.dy > 0) {
                  _yPosition = _yPosition > positionLimitTop + midlePosition
                      ? positionLimit
                      : _yPosition;
                }

                if (_yPosition != positionLimitTop && details.delta.dy < 0) {
                  _yPosition = _yPosition < positionLimit - midlePosition
                      ? positionLimitTop
                      : _yPosition;
                }

                if (_yPosition == positionLimit) {
                  _ShowMenu = true;
                } else if (_yPosition == positionLimitTop) {
                  _ShowMenu = false;
                }
              });
            },
            top:
                _yPosition, //!_ShowMenu ? _scrennHeigth * 0.24 : _scrennHeigth * 0.80,
            onChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
          MyDotsApp(
            top: _scrennHeigth * 0.74,
            currentIndex: _currentIndex,
          )
        ],
      ),
    );
  }
}
