import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

FToast fToast = FToast();

customToast(BuildContext context, String toastMessage) {
  fToast.init(context);

  Widget toast = Container(
    padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15.0),
      color: Color(0x33EB5757),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.close_rounded),
        SizedBox(
          width: 5.0,
        ),
        Text(toastMessage),
      ],
    ),
  );

  // Custom Toast Position
  fToast.showToast(
    child: toast,
    toastDuration: Duration(seconds: 2),
    gravity: ToastGravity.BOTTOM,
  );
}
