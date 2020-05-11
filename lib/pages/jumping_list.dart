import 'package:flutter/material.dart';
import 'package:flutter_widgets/flutter_widgets.dart';
import 'package:smart_restau/pages/order_page.dart';
import 'package:smart_restau/utils/constants.dart';
import 'package:smart_restau/utils/device_widget.dart';
import 'dart:io' show Platform;

import 'details_page.dart';

class JumpingList extends StatefulWidget {
  @override
  _JumpingListState createState() => _JumpingListState();
}

class _JumpingListState extends State<JumpingList> {
  final ItemScrollController itemScrollController = ItemScrollController();

  /// Listener that reports the position of items when the list is scrolled.
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();
  final ItemScrollController itemScrollController2 = ItemScrollController();

  /// Listener that reports the position of items when the list is scrolled.
  final ItemPositionsListener itemPositionsListener2 =
      ItemPositionsListener.create();
  @override
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MediaQuery.of(context).size.aspectRatio > 1
            ? null
            : AppBar(
                title: Text(APP_NAME),
                elevation: 0,
                bottom: PreferredSize(
                    preferredSize: Size.fromHeight(50),
                    child: Container(height: 50, child: getHeader())),
              ),
        floatingActionButton: GestureDetector(
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (ctx) => OrderPage()));
          },
          child: Container(
            alignment: Alignment.bottomRight,
            child: Container(
                decoration: CIRCULAR_DECORATION.copyWith(
                  color: Theme.of(context).primaryColor,
                ),
                height: 60,
                width: 60,
                child: Stack(
                  alignment: Alignment.center,
                  fit: StackFit.passthrough,
                  overflow: Overflow.visible,
                  children: <Widget>[
                    Icon(Icons.shopping_cart, size: 30, color: Colors.white),
                    Positioned(
                      bottom: 40,
                      right: 0,
                      child: Container(
                          padding: PADDING_ALL_8,
                          child: Text("10"),
                          decoration: CIRCULAR_DECORATION),
                    )
                  ],
                )),
          ),
        ),
        body: DeviceWidget(
          mobile: Column(
            children: <Widget>[
              Expanded(
                flex: 20,
                child: Container(
                  color: Colors.grey.withOpacity(0.1),
                  child: ScrollablePositionedList.builder(
                    itemCount: 20,
                    itemBuilder: _getItem,
                    itemScrollController: itemScrollController,
                    itemPositionsListener: itemPositionsListener,
                  ),
                ),
              ),
            ],
          ),
          tablet: Row(children: [
            Expanded(flex: 3, child: getHeader()),
            Expanded(
              flex: 12,
              child: Container(
                color: Colors.grey.withOpacity(0.1),
                child: ScrollablePositionedList.builder(
                  itemCount: 20,
                  itemBuilder: _getItem,
                  itemScrollController: itemScrollController,
                  itemPositionsListener: itemPositionsListener,
                ),
              ),
            ),
            Expanded(flex: 4, child: _buildCart())
          ]),
        ));
  }

  getHeader() {
    return Material(
      color: manageSize(context,
          mobile: Theme.of(context).primaryColor, tablet: Colors.white),
      elevation: manageSize(context, mobile: 0, tablet: 1),
      clipBehavior: Clip.none,
      child: ValueListenableBuilder<Iterable<ItemPosition>>(
        valueListenable: itemPositionsListener.itemPositions,
        builder: _getHeaderValueBuilder,
        child: ScrollablePositionedList.builder(
          itemCount: 20,
          scrollDirection: manageSize<Axis>(context,
              mobile: Axis.horizontal, tablet: Axis.vertical),
          physics: ClampingScrollPhysics(),
          itemBuilder: _getHeaderItemBuilder,
          itemScrollController: itemScrollController2,
          itemPositionsListener: itemPositionsListener2,
          reverse: false,
        ),
      ),
    );
  }

  Widget _getHeaderValueBuilder(
      BuildContext context, Iterable<ItemPosition> positions, Widget child) {
    int min, max;
    if (positions.isNotEmpty) {
      min = positions
          .where((ItemPosition position) => position.itemTrailingEdge > 0)
          .reduce((ItemPosition min, ItemPosition position) =>
              position.itemTrailingEdge < min.itemTrailingEdge ? position : min)
          .index;
      // Determine the last visible item by finding the item with the
      // greatest leading edge that is less than 1.  i.e. the last
      // item whose leading edge in visible in the viewport.
      max = positions
          .where((ItemPosition position) => position.itemLeadingEdge < 1)
          .reduce((ItemPosition max, ItemPosition position) =>
              position.itemLeadingEdge > max.itemLeadingEdge ? position : max)
          .index;

      if (itemScrollController2.isAttached) {
        itemScrollController2.scrollTo(
            // alignment: -50.0,
            curve: Curves.linear,
            index: min.compareTo(max) <= 0 ? min : max,
            duration: Duration(milliseconds: 700));
      }
    }
    return child;
  }

  Widget _getHeaderItemBuilder(BuildContext ctx, int index) {
    return GestureDetector(
      onTap: () async {
        await itemScrollController.scrollTo(
            index: index,
            duration: Duration(
              milliseconds: 500,
            ));
        await Future.delayed(Duration(milliseconds: 700));
        itemScrollController.jumpTo(index: index);
      },
      child: DeviceWidget(
        mobile: Padding(
          padding: PADDING_ALL_8,
          child: Chip(
            backgroundColor: Colors.white,
            label: Text(
              'Category $index'.toUpperCase(),
              style: TITLE_PRICE_BIG_BOLD,
            ),
          ),
        ),
        tablet: Column(
          children: <Widget>[
            DIVIDER_VERT_BIG,
            Image.asset(
              "images/img${index % 11}.png",
              height: 80,
              width: 80,
              fit: BoxFit.cover,
            ),
            DIVIDER_VERT_SMALL,
            Text(
              'Category $index'.toUpperCase(),
              style: TITLE_THREE,
            ),
            DIVIDER_VERT_BIG
          ],
        ),
      ),
    );
  }

  Widget _getItem(BuildContext context, int category) {
    return Column(
      children: <Widget>[
        DeviceWidget(
          mobile: DIVIDER_VERT_SMALL,
          tablet: DIVIDER_VERT_BIG,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Text(
                "Cayegory $category".toUpperCase(),
                style: manageSize(context,
                    tablet: TITLE_ONE,
                    mobile: TITLE_ONE.copyWith(fontSize: 21)),
              ),
              DeviceWidget(
                mobile: DIVIDER_VERT_SMALL,
                tablet: DIVIDER_VERT_BIG,
              ),
              LINE_SEPARATOTOR
            ],
          ),
        ),
        DeviceWidget(
          mobile: DIVIDER_VERT_SMALL,
          tablet: DIVIDER_VERT_BIG,
        ),
        GridView.builder(
          shrinkWrap: true,
          itemCount: category + 1,
          physics: NeverScrollableScrollPhysics(),
          // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5),
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent:
                  manageSize<double>(context, mobile: 135, tablet: 260),
              childAspectRatio:
                  manageSize<double>(context, mobile: 0.9, tablet: 0.8),
              crossAxisSpacing:
                  manageSize<double>(context, mobile: 2, tablet: 8),
              mainAxisSpacing: 2),
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => DetailsPage(
                    index: index,
                    tag: "tag$index$category",
                  ),
                ),
              ),
              child: Hero(
                tag: 'tag$index$category',
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      Image.asset(
                        "images/img${10 - (index % 11)}.png",
                        height: manageSize<double>(context,
                            mobile: IMAGE_SIZE_MOBILE_BIG,
                            tablet: IMAGE_SIZE_TABLET_BIG),
                        width: manageSize<double>(context,
                            mobile: IMAGE_SIZE_MOBILE_BIG,
                            tablet: IMAGE_SIZE_TABLET_BIG),
                        fit: BoxFit.cover,
                      ),
                      DIVIDER_VERT_SMALL,
                      Text(
                        "cat $category  item $index".toUpperCase(),
                        style: manageSize(context,
                            tablet: TITLE_TWO,
                            mobile: TITLE_TWO.copyWith(fontSize: 16)),
                      ),
                      DIVIDER_VERT_SMALL,
                      Text(
                        "2500 FCFA".toUpperCase(),
                        style: TITLE_PRICE_BIG,
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  _buildCart() {
    return Card(
      child: Flex(
        direction: Axis.vertical,
        children: <Widget>[
          Container(
            padding: PADDING_ALL_16,
            child: Text(
              "MY CART (8)".toUpperCase(),
              style: TITLE_PRICE_BIG,
            ),
          ),
          Divider(
            endIndent: 16,
            indent: 16,
            thickness: 1,
          ),
          Expanded(
            child: ListView.separated(
                itemCount: 8,
                shrinkWrap: true,
                itemBuilder: (BuildContext ctx, int index) {
                  return Row(
                    children: <Widget>[
                      Expanded(
                        flex: 5,
                        child: Column(
                          children: <Widget>[
                            DIVIDER_VERT_BIG,
                            Image.asset(
                              "images/img${index % 3}.png",
                              height: 100,
                              width: 100,
                              fit: BoxFit.cover,
                            ),
                            DIVIDER_VERT_BIG,
                            Text(
                              'Name $index '.toUpperCase(),
                              style: TITLE_THREE,
                            ),
                            DIVIDER_VERT_SMALL,
                            Text(
                              '1500 F'.toUpperCase(),
                              style: TITLE_PRICE_BIG_BOLD,
                            )
                          ],
                        ),
                      ),
                      Column(
                        children: <Widget>[
                          Text("QTY"),
                          Icon(Icons.keyboard_arrow_up),
                          Text("1"),
                          Icon(Icons.keyboard_arrow_down)
                        ],
                      ),
                      DIVIDER_HOR_BIG
                    ],
                  );
                },
                separatorBuilder: (BuildContext context, int indew) => Divider(
                      endIndent: 16,
                      thickness: 1,
                      indent: 16,
                    )),
          ),
          Container(
            padding: PADDING_ALL_16,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'total:'.toUpperCase(),
                  style: TITLE_PRICE_BIG,
                ),
                Text(
                  '25000 F'.toUpperCase(),
                  style: TITLE_PRICE_BIG_BOLD,
                )
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (ctx) => OrderPage()));
            },
            child: Container(
              height: 60,
              child: Text("GHECK OUT"),
              color: Theme.of(context).accentColor,
              alignment: Alignment.center,
            ),
          ),
        ],
      ),
    );
  }
}
