import 'package:flutter/material.dart';
import 'package:roomie_lah/constants.dart';

class appBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color color, textColor;
  Size get preferredSize => Size(
        200,
        65,
      );
  const appBar({
    required Key key,
    required this.title,
    this.color = kPrimaryColor,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return PreferredSize(
      preferredSize: Size(
        MediaQuery.of(context).size.width,
        MediaQuery.of(context).size.height * 0.075, // 10% of the height
      ),
      child: AppBar(
        automaticallyImplyLeading: false,
        key: key,
        centerTitle: true,
        title: Text(title, style: kLargeText, textAlign: TextAlign.center),
        backgroundColor: color,
        actions: [],
      ),
    );
  }
}
