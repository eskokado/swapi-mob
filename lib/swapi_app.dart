import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swapi_mob/stub_data.dart';
import 'package:swapi_mob/swapi.dart';
import 'package:swapi_mob/swapi_home.dart';
import 'package:swapi_mob/swapi_menu.dart';

enum SwapiViewType {
  home,
  list,
}

class SwapiApp extends StatelessWidget {
  const SwapiApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: _SwapiHomePage(),
    );
  }
}

class _SwapiHomePage extends StatelessWidget {
  const _SwapiHomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var state = Provider.of<AppState>(context);
    return Scaffold(
      appBar: AppBar(
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Padding(
              padding: EdgeInsets.fromLTRB(0.0, 0.0, 8.0, 0.0),
              child: Icon(Icons.star, size: 24.0),
            ),
            Text('Star War API'),
          ],
        ),
        backgroundColor: Colors.green[700],
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 0.0, 16.0, 0.0),
            child: IconButton(
              icon: Icon(
                state.viewType == SwapiViewType.home
                    ? Icons.list
                    : Icons.home,
                size: 32.0,
              ),
              onPressed: () {
                state.setViewType(
                  state.viewType == SwapiViewType.home
                      ? SwapiViewType.list
                      : SwapiViewType.home,
                );
            },
            )
          )
        ]
      ),
      body: IndexedStack(
        index: state.viewType == SwapiViewType.home ? 0 : 1,
        children: const [
          SwapiHome(),
          SwapiMenu()
          // PlaceMap(center: LatLng(45.521563, -122.677433)),
          // PlaceList()
        ],
      ),
    );
  }
}

class AppState extends ChangeNotifier {
  AppState({
    this.swapis = StubData.swapis,
    this.viewType = SwapiViewType.home,
  });

  List<Swapi> swapis;
  SwapiViewType viewType;

  void setViewType(SwapiViewType viewType) {
    this.viewType = viewType;
    notifyListeners();
  }

  void setSwapis(List<Swapi> newSwapis) {
    swapis = newSwapis;
    notifyListeners();
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AppState &&
        other.swapis == swapis &&
        other.viewType == viewType;
  }

  @override
  int get hashCode => hashValues(swapis, viewType);
}