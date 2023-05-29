import 'package:flutter/material.dart';

Widget adaptiveSpan(BuildContext context, String text1, String text2,  {double padding = 16}) {
  return Padding(
    padding: EdgeInsets.only(top: padding),
    child: Align(
      alignment: Alignment.topLeft,
      child: RichText(
        textAlign: TextAlign.left,
        text: TextSpan(
          style: TextStyle(
            fontSize: 18,
            fontFamily: 'MuseoSansCyrl-600',
            color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black
          ),
          children: <TextSpan>[
            TextSpan(
                text: text1,
                style: const TextStyle(
                    fontWeight: FontWeight.w400,
                )),
            TextSpan(
                text: text2,
                style: const TextStyle(
                    fontWeight: FontWeight.w600,
                )),
          ],
        ),
      ),
    ),
  );
}
