import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';
import 'package:wikipidia/src/core/app_constants.dart';
import 'package:wikipidia/src/presentation/features/result/controller/result.dart';

class Result extends StatefulWidget {
  final String titel;
  const Result({
    Key key,
    this.titel,
  }) : super(key: key);
  @override
  _ResultState createState() => _ResultState();
}

class _ResultState extends State<Result> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      context.read<ResultController>().getResult(text: widget.titel);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.titel.text.make(),
      ),
      body: SingleChildScrollView(
        child: Consumer<ResultController>(
          builder: (context, cotroller, child) {
            return cotroller.appState == AppState.Busy
                ? Container()
                : Column(
                    children: [
                      Image.network(
                        cotroller.containts.thumbnail == null
                            ? "https://seeba.se/wp-content/themes/consultix/images/no-image-found-360x260.png"
                            : cotroller.containts.thumbnail.source.isEmptyOrNull
                                ? "https://seeba.se/wp-content/themes/consultix/images/no-image-found-360x260.png"
                                : cotroller.containts.thumbnail.source,
                        height: context.safePercentHeight * 20,
                        width: double.maxFinite,
                        fit: BoxFit.contain,
                      ),
                      Html(data: cotroller.containts.extract ?? ""),
                    ],
                  );
          },
        ),
      ),
    );
  }
}
