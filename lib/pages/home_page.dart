import "package:flutter/material.dart";
import 'package:smart_restau/pages/jumping_list.dart';
import 'package:smart_restau/utils/constants.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  Animation _animation;
  AnimationController _animationController;
  ScrollController _scrollController = ScrollController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    _animation =
        Tween<double>(begin: 0.0, end: 0.6).animate(_animationController)
          ..addListener(() {
            setState(() {});
          });
    _animationController.forward();
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _scroller();
      }
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("initstate");
  }

  _scroller() async {
    while (true && _scrollController.hasClients) {
      // await Future.delayed(Duration(milliseconds: 100));
      await _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(seconds: 20),
          curve: Curves.linear);
      // await Future.delayed(Duration(seconds: 10));
      await _scrollController.animateTo(0.0,
          duration: Duration(milliseconds: 1), curve: Curves.easeOut);
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    _scrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image.asset(
            "images/img5.png",
            fit: BoxFit.cover,
          ),
          Column(
            children: <Widget>[
              Expanded(
                flex: 8,
                child: FractionallySizedBox(
                  widthFactor: 0.8,
                  heightFactor: 0.8,
                  alignment: Alignment.center,
                  child: Material(
                    color: Colors.black.withOpacity(0.2),
                    child: Padding(
                      padding: PADDING_ALL_16,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                _navigate(0);
                              },
                              child: Container(
                                alignment: Alignment.center,
                                constraints: BoxConstraints.expand(),
                                decoration: BoxDecoration(
                                    color: Colors.green
                                        .withOpacity(_animation.value)),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                        width: 2, color: Colors.white),
                                  ),
                                  padding: PADDING_ALL_16,
                                  child: Text(
                                    "Play".toUpperCase(),
                                    style:
                                        TITLE_ONE.copyWith(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          DIVIDER_HOR_BIG,
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                _navigate(1);
                              },
                              child: Container(
                                alignment: Alignment.center,
                                constraints: BoxConstraints.expand(),
                                decoration: BoxDecoration(
                                    color: Colors.red
                                        .withOpacity(_animation.value)),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                        width: 2, color: Colors.white),
                                  ),
                                  padding: PADDING_ALL_16,
                                  child: Text(
                                    "Pay".toUpperCase(),
                                    style:
                                        TITLE_ONE.copyWith(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          DIVIDER_HOR_BIG,
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                _navigate(JumpingList());
                              },
                              child: Container(
                                alignment: Alignment.center,
                                constraints: BoxConstraints.expand(),
                                decoration: BoxDecoration(
                                    color: Colors.yellow
                                        .withOpacity(_animation.value)),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                        width: 2, color: Colors.white),
                                  ),
                                  padding: PADDING_ALL_16,
                                  child: Text(
                                    "Order".toUpperCase(),
                                    style:
                                        TITLE_ONE.copyWith(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.black,
                  alignment: Alignment.center,
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width,
                        ),
                        Text(
                          "Hello! Welcome to the smartest restaurant in Cameroon. Discover our rich menu and flavour your favorites meals. This app is made by BrainStorm contact us on +237 697 86 40 00 or send an e-mail to consti1er@gmail.com",
                          maxLines: 1,
                          style: TITLE_TWO.copyWith(color: Colors.white),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  _navigate(stat) {
    if (stat is! int) {
      Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => stat));
    } else {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text("Non implementé"),
      ));
    }
  }
}
