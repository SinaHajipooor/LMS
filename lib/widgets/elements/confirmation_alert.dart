import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ConfirmationAlert extends StatelessWidget {
  final BuildContext alertContext;
  final VoidCallback startUserExam;
  const ConfirmationAlert({super.key, required this.alertContext, required this.startUserExam});

  _showAlert() {
    Alert(
            context: alertContext,
            type: AlertType.warning,
            title: "شروع آزمون",
            desc: "آیا مطمعن هستید که آزمون را شروع می کنید ؟",
            style: AlertStyle(
              titleStyle: const TextStyle(fontWeight: FontWeight.bold),
              descStyle: const TextStyle(fontSize: 16),
              overlayColor: Colors.black.withOpacity(0.6),
              animationType: AnimationType.grow,
              alertBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0), side: BorderSide.none),
            ),
            buttons: [
              DialogButton(
                onPressed: startUserExam,
                width: 120,
                color: const Color.fromRGBO(0, 179, 134, 1.0),
                child: const Text("بله", style: TextStyle(color: Colors.white, fontSize: 20)),
              ),
              DialogButton(
                onPressed: () => Navigator.pop(alertContext),
                width: 120,
                color: Colors.red,
                child: const Text("خیر", style: TextStyle(color: Colors.white, fontSize: 20)),
              ),
            ],
            closeIcon: const Icon(Icons.close, color: Colors.red))
        .show();
  }

  @override
  Widget build(BuildContext context) {
    return _showAlert();
  }
}
