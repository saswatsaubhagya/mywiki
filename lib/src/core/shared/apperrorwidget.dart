import 'package:flutter/material.dart';

class AppErrorWidget extends StatelessWidget {
  final FlutterErrorDetails errorDetails;
  final bool isDev;
  const AppErrorWidget({
    Key key,
    @required this.errorDetails,
    this.isDev = false,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: 15,
              ),
              Center(
                child: Text("Something went wrong"),
              ),
              if (!isDev)
                Container(
                  child: Expanded(
                      child: Text(
                    "$errorDetails",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  )),
                ),
              Divider(),
              RaisedButton(
                onPressed: () {},
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                color: Colors.greenAccent,
                child: Text("Restart the app"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
