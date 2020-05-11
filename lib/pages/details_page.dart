import 'package:flutter/material.dart';
import 'package:smart_restau/utils/constants.dart';
import 'package:smart_restau/utils/device_widget.dart';

import '../main.dart';

class DetailsPage extends StatefulWidget {
  final int index;
  final String tag;

  const DetailsPage({Key key, this.index, this.tag}) : super(key: key);
  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  final List list1 = List.filled(5, false);
  final List list2 = List.filled(8, false);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: DeviceWidget(
        mobile: NestedScrollView(
          headerSliverBuilder: (ctx, bool a) => [
            SliverAppBar(
              pinned: true,floating: true,snap: true,
                expandedHeight: 250,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text('Food name'),
                  background: Image.asset(
                    "images/img5.png",
                    fit: BoxFit.cover,
                    height: 250,
                  ),
                ))
          ],
          body: Column(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                      child: Column(
                    children: <Widget>[
                      Text("2 500F", style: TITLE_PRICE_BIG_BOLD),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("QUantity:".toUpperCase(),
                              style: TITLE_PRICE_BIG),
                          MaterialButton(
                            onPressed: () {},
                            child: Icon(
                              Icons.keyboard_arrow_up,
                              color: Colors.green,
                            ),
                          ),
                          Padding(
                            padding: PADDING_ALL_8,
                            child: Text(
                              "1",
                              style: TITLE_PRICE_BIG_BOLD,
                            ),
                          ),
                          MaterialButton(
                            onPressed: () {},
                            child: Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.green,
                            ),
                          )
                        ],
                      ),
                      Text(MyHomePage.list[0]['content'][1]['content']),
                      DIVIDER_VERT_BIG,
                      _getCategoryTitle("Select your size"),
                      _getDetailsBloc(),
                      DIVIDER_VERT_BIG,
                      _getCategoryTitle("Select your size"),
                      _getDetailsBloc(isFirst: false),
                    ],
                  )),
                ),
              ),
              Container(
                alignment: Alignment.center,
                color: Theme.of(context).accentColor,
                height: 50,
                width: double.infinity,
                child: Text("Add to cart (3500F)"),
              )
            ],
          ),
        ),
        tablet: Row(
          children: <Widget>[
            Expanded(flex: 4, child: _getProductDescription()),
            Expanded(flex: 5, child: _getAccessories())
          ],
        ),
      ),
    );
  }

  _getCategoryTitle(String text) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Text(
          text.toUpperCase(),
          style: TITLE_THREE,
        ),
        DIVIDER_HOR_BIG,
        LINE_SEPARATOTOR,
      ],
    );
  }

  _getAccessories() {
    return Container(
      color: Colors.grey.withOpacity(0.1),
      child: Row(
        children: <Widget>[
          DIVIDER_HOR_BIG,
          DIVIDER_HOR_BIG,
          Expanded(
            child: Flex(direction: Axis.vertical,
                // fit: Flexf,
                children: [
                  SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        DIVIDER_VERT_BIG,
                        _getCategoryTitle("Select your size"),
                        _getDetailsBloc(),
                        DIVIDER_VERT_BIG,
                        _getCategoryTitle("Select your size"),
                        _getDetailsBloc(isFirst: false),
                      ],
                    ),
                  ),
                ]),
          ),
        ],
      ),
    );
  }

  _getDetailsBloc({bool isFirst = true}) {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: (isFirst ? list1 : list2).length,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 150, crossAxisSpacing: 16, childAspectRatio: 0.8),
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              (isFirst ? list1 : list2)[index] =
                  !(isFirst ? list1 : list2)[index];
            });
          },
          child: Card(
            color: (isFirst ? list1 : list2)[index]
                ? Colors.white
                : Colors.transparent,
            elevation: (isFirst ? list1 : list2)[index] ? 2 : 0,
            child: Column(
              children: <Widget>[
                DIVIDER_VERT_BIG,
                Image.asset(
                  "images/img${index % 11}.png",
                  height: 80,
                  width: 80,
                  fit: BoxFit.cover,
                ),
                DIVIDER_VERT_BIG,
                Text(
                  "Size $index".toUpperCase(),
                  style: TITLE_THREE,
                )
              ],
            ),
          ),
        );
      },
    );
  }

  _getProductDescription() {
    return Card(
      child: Padding(
        padding: PADDING_ALL_16,
        child: Column(
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Image.asset(
                      "images/img5.png",
                      height: 150,
                      width: 150,
                      fit: BoxFit.cover,
                    ),
                    DIVIDER_VERT_BIG,
                    Text(
                      'Food Name'.toUpperCase(),
                      style: TITLE_TWO,
                    ),
                    DIVIDER_VERT_SMALL,
                    Text(
                        "Description +${MyHomePage.list[0]['content'][1]['content']}"),
                    DIVIDER_VERT_SMALL,
                    Text(
                      "3500 Kcal",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text("QUantity:".toUpperCase(),
                                style: TITLE_PRICE_BIG),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                MaterialButton(
                                  onPressed: () {},
                                  child: Icon(
                                    Icons.keyboard_arrow_up,
                                    color: Colors.green,
                                  ),
                                ),
                                Padding(
                                  padding: PADDING_ALL_8,
                                  child: Text(
                                    "1",
                                    style: TITLE_PRICE_BIG_BOLD,
                                  ),
                                ),
                                MaterialButton(
                                  onPressed: () {},
                                  child: Icon(
                                    Icons.keyboard_arrow_down,
                                    color: Colors.green,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              "TOTAL:".toUpperCase(),
                              style: TITLE_PRICE_BIG,
                            ),
                            DIVIDER_HOR_BIG,
                            Text(
                              "2500 FCFA".toUpperCase(),
                              style: TITLE_PRICE_BIG_BOLD,
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: MaterialButton(
                    color: ACCENT_COLOR,
                    onPressed: () {
                      Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text('Ajouté au panier'),
                      ));
                    },
                    child: Text("ADD TO CART"),
                  ),
                ),
                DIVIDER_HOR_BIG,
                Expanded(
                  flex: 1,
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("CANCEL"),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
