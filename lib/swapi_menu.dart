import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swapi_mob/swapi_app.dart';
import 'package:swapi_mob/swapi_list.dart';

import 'swapi.dart';

class SwapiMenu extends StatefulWidget {
  const SwapiMenu({Key key}) : super(key: key);

  @override
  SwapiMenuState createState() => SwapiMenuState();
}

class SwapiMenuState extends State<SwapiMenu> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    var state = Provider.of<AppState>(context);
    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 8.0),
            controller: _scrollController,
            shrinkWrap: true,
            children: state.swapis
              .map((swapi) => _SwapiListTile(
                swapi: swapi,
                onSwapiChanged: (value) => _onSwapiChanged(value),
              )
            ).toList(),
          ),
        )
      ],
    );
  }

  void _onSwapiChanged(Swapi value) {
    // Replace the place with the modified version.
    final newSwapis =
    List<Swapi>.from(Provider.of<AppState>(context, listen: false).swapis);
    final index = newSwapis.indexWhere((swapi) => swapi.id == value.id);
    newSwapis[index] = value;

    Provider.of<AppState>(context, listen: false).setSwapis(newSwapis);
  }

}

class _SwapiListTile extends StatelessWidget {
  final Swapi swapi;

  final ValueChanged<Swapi> onSwapiChanged;
  const _SwapiListTile({
    Key key,
    this.swapi,
    this.onSwapiChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push<void>(
        context,
        MaterialPageRoute(builder: (context) {
          return SwapiList(
            swapi: swapi,
          );
        }),
      ),
      child: Container(
        padding: const EdgeInsets.only(top: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              swapi.name,
              textAlign: TextAlign.left,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
            Text(
              swapi.url,
              style: Theme.of(context).textTheme.subtitle1,
              overflow: TextOverflow.ellipsis,
            ),
            Divider(
              height: 2.0,
              color: Colors.grey[700],
            ),
          ],
        ),
      ),
    );
  }
}