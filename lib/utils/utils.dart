import 'package:flutter/material.dart';

class Utils {
  static Widget errorWidget(Function stateFunction) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Image.asset('images/error.png'),
          ),
          Text(
            "Somethings Not Right",
            style: TextStyle(fontSize: 22.0),
          ),
          Text(
            "Sorry, We're having some technical issues (as you can see), Try to tap and refresh the screen.\nSometimes works :)",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 18,
            ),
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FlatButton(
              onPressed: () {
                stateFunction();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: Text(
                      "RETRY",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              color: Colors.indigoAccent,
            ),
          )
        ],
      ),
    );
  }
}
