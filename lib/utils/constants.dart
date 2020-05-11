import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const Color PRIMARY_COLOR = Colors.blue;
const Color ACCENT_COLOR = Colors.amber;
const TextStyle TITLE_ONE =
    TextStyle(fontSize: 26, color: Colors.grey, fontWeight: FontWeight.bold);
const TextStyle TITLE_TWO =
    TextStyle(fontSize: 21, color: Colors.black, fontWeight: FontWeight.bold);
const TextStyle TITLE_THREE =
    TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold);
final TextStyle TITLE_THREE_LIGHT = TITLE_TWO.copyWith(color: ACCENT_COLOR);
const TextStyle TITLE_PRICE_BIG =
    TextStyle(fontSize: 15, color: Colors.grey, fontWeight: FontWeight.bold);
const TextStyle TITLE_PRICE_BIG_BOLD =
    TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold);
const TextStyle TITLE_PRICE_SMALL =
    TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.bold);
const TextStyle TITLE_PRICE_SMALL_BOLD =
    TextStyle(fontSize: 12, color: Colors.black, fontWeight: FontWeight.bold);
const TextStyle TITLE_COMPLEMENT =
    TextStyle(fontSize: 12, color: Colors.black, fontWeight: FontWeight.bold);
const EdgeInsets PADDING_ALL_16 = EdgeInsets.all(16);
const EdgeInsets PADDING_ALL_8 = EdgeInsets.all(8);
const EdgeInsets PADDING_VERT_16 = EdgeInsets.symmetric(vertical: 16);
const EdgeInsets PADDING_HOR_16 = EdgeInsets.symmetric(horizontal: 16);
const EdgeInsets PADDING_VERT_8 = EdgeInsets.symmetric(vertical: 8);
const EdgeInsets PADDING_HOR_8 = EdgeInsets.symmetric(horizontal: 8);
const String APP_NAME = "SMART RESTAU";
const SizedBox DIVIDER_HOR_SMALL = SizedBox(
  width: 8,
);
const SizedBox DIVIDER_VERT_SMALL = SizedBox(
  height: 8,
);
const SizedBox DIVIDER_HOR_BIG = SizedBox(
  width: 16,
);
const SizedBox DIVIDER_VERT_BIG = SizedBox(
  height: 16,
);
const Widget LINE_SEPARATOTOR = Expanded(
  child: const Divider(
    color: Colors.grey,
    thickness: 1,
  ),
);
const double IMAGE_SIZE_MOBILE_BIG = 80;
const double IMAGE_SIZE_MOBILE_SMALL = 40;
const double IMAGE_SIZE_TABLET_BIG = 160;
const double IMAGE_SIZE_TABLET_SMALL = 80;
const DEFAULT_BORDER_SIDE =
    BorderSide(width: 1, color: Colors.white, style: BorderStyle.solid);
const BoxDecoration CIRCULAR_DECORATION = BoxDecoration(
    color: Colors.amber,
    shape: BoxShape.circle,
    border: Border(
        bottom: DEFAULT_BORDER_SIDE,
        left: DEFAULT_BORDER_SIDE,
        top: DEFAULT_BORDER_SIDE,
        right: DEFAULT_BORDER_SIDE));

T manageSize<T>(BuildContext context,
    {@required T mobile, @required T tablet}) {
  return MediaQuery.of(context).size.aspectRatio > 1 ? tablet : mobile;
}
