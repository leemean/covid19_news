import 'package:flutter/material.dart';

class ErrorConection extends StatelessWidget {

  final VoidCallback tryAgain;

  ErrorConection({Key key, this.tryAgain}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      child: Center(
        child: new Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 20.0,
            horizontal: 8.0,
          ),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Icon(
                  Icons.cloud_off,
                  size: 100.0,
                  color: Colors.blue,
                ),
                new Text(
                  "connection error",
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: new FlatButton(
                    shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                    onPressed: tryAgain,
                    child: new Text("try again"),
                    color: Colors.blue,
                    textColor: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
