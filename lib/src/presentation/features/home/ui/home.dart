import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wikipidia/src/infrastructure/models/suggestion.dart';
import 'package:wikipidia/src/presentation/features/home/controller/home.dart';

import 'package:velocity_x/velocity_x.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:wikipidia/src/presentation/features/result/controller/result.dart';
import 'package:wikipidia/src/presentation/features/result/ui/result.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Wikipedia"),
      ),
      body: ChangeNotifierProvider.value(
        value: HomeController(),
        child: Container(
          child: Column(
            children: [
              HeightBox(context.percentHeight * 10),
              CachedNetworkImage(
                imageUrl:
                    "https://upload.wikimedia.org/wikipedia/commons/thumb/d/de/Wikipedia_Logo_1.0.png/800px-Wikipedia_Logo_1.0.png",
                height: 150,
                width: double.maxFinite,
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
              SuggestionBox(),
              // "Search"
              //     .text
              //     .white
              //     .bold
              //     .make()
              //     .box
              //     .rounded
              //     .padding(EdgeInsets.fromLTRB(25, 10, 25, 10))
              //     .blue400
              //     .makeCentered()
              //     .onTap(() {})
            ],
          ),
        ),
      ),
    );
  }
}

class SuggestionBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(32.0),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 10.0,
          ),
          Consumer<HomeController>(
            builder: (ctx, controller, _) {
              return TypeAheadField(
                textFieldConfiguration: TextFieldConfiguration(
                  autofocus: true,
                  style: DefaultTextStyle.of(context)
                      .style
                      .copyWith(fontStyle: FontStyle.italic),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: 'What are you looking for?',
                  ),
                ),
                suggestionsCallback: (pattern) async {
                  if (pattern.length > 1) {
                    await controller.getSuggestion(text: pattern);
                  }
                  return controller.suggestions;
                },
                itemBuilder: (context, Suggestion suggestion) {
                  return ListTile(
                    leading: CachedNetworkImage(
                      imageUrl: suggestion.thumbnail == null
                          ? "https://seeba.se/wp-content/themes/consultix/images/no-image-found-360x260.png"
                          : suggestion.thumbnail.source.isEmptyOrNull
                              ? "https://seeba.se/wp-content/themes/consultix/images/no-image-found-360x260.png"
                              : suggestion.thumbnail.source,
                      height: 50,
                      width: 50,
                    ),
                    title: Text(
                      suggestion.title ?? "",
                    ),
                    subtitle: Text('\$${suggestion.terms.description[0]}'),
                  );
                },
                onSuggestionSelected: (Suggestion suggestion) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ChangeNotifierProvider(
                        create: (_) => ResultController(),
                        child: Result(
                          titel: suggestion.title,
                        ),
                      ),
                    ),
                  );
                },
                hideOnEmpty: true,
                noItemsFoundBuilder: (context) => SizedBox(),
              );
            },
          ),
        ],
      ),
    );
  }
}
