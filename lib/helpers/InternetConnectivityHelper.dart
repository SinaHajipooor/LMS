import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:connectivity/connectivity.dart';

class InternetConnectivityHelper {
  static void showConnectionDialog(BuildContext context) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.scale,
      body: const SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text('عدم اتصال به اینترنت', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20, bottom: 10),
              child: Center(
                child: Text(
                  'اتصال شما به اینترنت برقرار نیست . لطفا دوباره تلاش کنید',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
      btnOk: ElevatedButton(
        onPressed: () {
          Navigator.of(context).pop();
          checkInternetConnectivity(context);
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
        ),
        child: const Text('تلاش مجدد'),
      ),
      btnCancel: ElevatedButton(
        onPressed: () {},
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 224, 224, 224)),
        ),
        child: const Text('تنظیمات', style: TextStyle(color: Colors.black)),
      ),
    ).show();
  }

  static Future<void> checkInternetConnectivity(BuildContext context) async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      showConnectionDialog(context);
    } else {
      print("user is connected to internet");
    }
  }
}
