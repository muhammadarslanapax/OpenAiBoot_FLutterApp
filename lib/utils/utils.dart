import 'package:flutter/material.dart';

import '../res/colors.dart';
import '../widgets/dropdown.dart';
import '../widgets/textWidget.dart';

class Utils {
  static Future<void> bottomNav({required BuildContext context}) async {
    await showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        backgroundColor: scafffoldBackGroundColor,
        context: context,
        builder: (context) {
          return const Padding(
            padding: EdgeInsets.all(18.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                    child: NewWidget(
                  lebel: 'Chosen Modal : ',
                  fontSize: 16,
                )),
                Flexible(child: DropDownM())
              ],
            ),
          );
        });
  }
}
