import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:swapi_mob/swapi.dart';
import 'package:swapi_mob/swapi_app.dart';

class HomeConfiguration {
  final List<Swapi> swapis;

  const HomeConfiguration({
    this.swapis,
  });

  @override
  int get hashCode => swapis.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    if (other.runtimeType != runtimeType) {
      return false;
    }

    return other is HomeConfiguration &&
        other.swapis == swapis;
  }

  static HomeConfiguration of(AppState appState) {
    return HomeConfiguration(
      swapis: appState.swapis,
    );
  }
}

class SwapiHome extends StatefulWidget {
  const SwapiHome({
    Key key,
  }) : super(key: key);

  @override
  SwapiHomeState createState() => SwapiHomeState();
}

class SwapiHomeState extends State<SwapiHome> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    var state = Provider.of<AppState>(context);
    return Column(
      children: const [
      ]
    );
  }
}