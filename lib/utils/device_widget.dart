import 'package:flutter/material.dart';

class DeviceWidget extends StatelessWidget {

  final Widget tablet, mobile;

  const DeviceWidget({Key key, this.tablet, this.mobile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.aspectRatio>1;
    return isTablet? tablet:mobile;
  }
}