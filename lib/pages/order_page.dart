import 'dart:async';

import 'package:flutter/material.dart';
import 'package:smart_restau/utils/constants.dart';
import 'package:smart_restau/utils/device_widget.dart';

class OrderPage extends StatefulWidget {
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final animatedKey = GlobalKey<AnimatedListState>();
  final List list = List.filled(1, 0, growable: true);
  @override
  void initState() {
    Timer.periodic(Duration(milliseconds: 150), (timer) {
      list.insert(list.length - 1, 0);
      animatedKey.currentState
          .insertItem(list.length - 1, duration: Duration(milliseconds: 500));
      if (timer.tick == 10) {
        timer.cancel();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: manageSize(context,
          tablet: null,
          mobile: AppBar(
            title: Text("Review & Order"),
          )),
      body: DeviceWidget(
        mobile: Column(
          children: <Widget>[
            Expanded(child: Padding(padding: PADDING_ALL_16, child: _getAnimatedList())),
            DIVIDER_HOR_BIG,
            Container(
              height: 50,
              width: double.infinity,
              child: Row(
                children: <Widget>[
                  Expanded(flex: 2,child: Container(height: 50,
                  color: Theme.of(context).accentColor,
                  alignment: Alignment.center,
                  child: Text("Pay (25 000F)"),
                  ),),
                  Expanded(flex: 1,child: Container(height: 50,
                  color: Theme.of(context).primaryColor,
                  alignment: Alignment.center,
                  child: Text("Enter Coupon",style: TITLE_THREE.copyWith(color: Colors.white,),),
                  ),)
                ],
              ),
            )
          ],
        ),
        tablet: Row(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Container(
                padding: PADDING_ALL_16,
                color: Colors.grey.withOpacity(0.1),
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Review & Order'.toUpperCase(),
                        style: TITLE_ONE,
                      ),
                    ),
                    DIVIDER_VERT_BIG,
                    Expanded(flex: 8, child: _getAnimatedList()),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Card(
                child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 3,
                      child: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Row(
                                children: <Widget>[
                                  Icon(Icons.keyboard_arrow_left),
                                  Padding(
                                    padding: PADDING_ALL_16,
                                    child: Text(
                                      "Back to Menu".toUpperCase(),
                                      style: TITLE_PRICE_BIG,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              padding: PADDING_ALL_16,
                              margin: PADDING_ALL_16,
                              color: Colors.grey.withOpacity(0.1),
                              child: ListView.separated(
                                shrinkWrap: true,
                                itemCount: 3,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (BuildContext ctx, int ind) => Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      "Category $ind".toUpperCase(),
                                      style: TITLE_THREE,
                                    ),
                                    Text('$ind 500F', style: TITLE_PRICE_BIG),
                                  ],
                                ),
                                separatorBuilder:
                                    (BuildContext context, int index) =>
                                        DIVIDER_VERT_BIG,
                              ),
                            ),
                            DIVIDER_VERT_BIG,
                            DIVIDER_VERT_BIG,
                            Padding(
                              padding: PADDING_ALL_16,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "TOTAL".toUpperCase(),
                                    style: TITLE_THREE,
                                  ),
                                  Text('25 500F', style: TITLE_PRICE_BIG_BOLD),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Column(
                      children: <Widget>[
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                margin: PADDING_ALL_16,
                                color: Theme.of(context).accentColor,
                                alignment: Alignment.center,
                                child: Text("PAY"),
                                height: 80,
                              ),
                            )
                          ],
                        ),
                        DIVIDER_VERT_BIG,
                        FlatButton(
                          child: Text("ENTER COUPON"),
                          onPressed: () {},
                        ),
                        DIVIDER_VERT_BIG
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _getAnimatedList() {
    return AnimatedList(
      key: animatedKey,
      shrinkWrap: true,
      initialItemCount: list.length,
      itemBuilder: (BuildContext ctx, int index, Animation<double> animation) {
        final Animatable<Offset> _tween =
            Tween<Offset>(begin: Offset(-1, 0), end: Offset.zero)
                .chain(CurveTween(curve: Curves.easeIn));
        Animation<Offset> offset = animation.drive(_tween);
        return Padding(
            padding: PADDING_VERT_8, child: _getTransitionItem(offset, index));
      },
    );
  }

  remove(index) {
    list.removeAt(index);

    animatedKey.currentState.removeItem(index, (a, animation) {
      final Animatable<Offset> _tween =
          Tween<Offset>(begin: Offset.zero, end: Offset(-1, 0))
              .chain(CurveTween(curve: Curves.easeIn));
      Animation<Offset> offset = animation.drive(_tween);
      return _getTransitionItem(offset, index);
    });
  }

  _getTransitionItem(offset, index) {
    return SlideTransition(
        position: offset,
        child: DeviceWidget(
          mobile: Dismissible(
            key: GlobalKey(),background: Container(color: Colors.red, height: 100,),
                      child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Image.asset(
                  "images/img8.png",
                  height: IMAGE_SIZE_MOBILE_BIG,
                  width: IMAGE_SIZE_MOBILE_BIG,
                  fit: BoxFit.cover,
                ),
                DIVIDER_HOR_BIG,
                Expanded(
                                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Food Name ($index 500F)",textAlign: TextAlign.justify,
                        style: TITLE_TWO,
                      ),
                      DIVIDER_VERT_SMALL,
                      Row(
                        children: <Widget>[
                          Text("QTY"),
                          Icon(Icons.keyboard_arrow_up),
                          Text("1"),
                          Icon(Icons.keyboard_arrow_down)
                        ],
                      ),
                      DIVIDER_VERT_SMALL,
                      GridView(
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 120,childAspectRatio: 2.2),
                        physics: NeverScrollableScrollPhysics(),
                        children: List.generate(
                              3,
                              (i) => Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Chip(
                                      label: Text('item $i', maxLines: 1,),
                                      deleteIcon: Icon(Icons.close),
                                      onDeleted: () {},
                                    ),
                                  )),
                        ),
                        Divider(thickness: 1,)
                      ])

                  ),]
                ), 
          )
            
          ,
          tablet: Row(
            children: <Widget>[
              Image.asset(
                "images/img8.png",
                height: IMAGE_SIZE_TABLET_BIG,
                width: IMAGE_SIZE_TABLET_BIG,
                fit: BoxFit.cover,
              ),
              manageSize(context, tablet: DIVIDER_HOR_BIG, mobile: Container()),
              manageSize(context, tablet: DIVIDER_HOR_BIG, mobile: Container()),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "food name".toUpperCase(),
                      style: TITLE_THREE,
                    ),
                    DIVIDER_VERT_BIG,
                    ListView.builder(
                      itemCount: 3,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (ctx, i) => Row(children: <Widget>[
                        Expanded(flex: 7, child: Text("item $i")),
                        Expanded(
                          flex: 2,
                          child: GestureDetector(
                            onTap: () {
                              remove(i);
                            },
                            child: Icon(Icons.close),
                          ),
                        )
                      ]),
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[],
                ),
              ),
              Text(
                "$index 500 F",
                style: TITLE_PRICE_BIG_BOLD,
              ),
              Expanded(
                child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.grey),
                    child: Icon(Icons.close, color: Colors.black)),
              )
            ],
          ),
        ));
  }
}
