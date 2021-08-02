import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swapi_mob/swapi.dart';
import 'package:swapi_mob/swapi_film_details.dart';

import 'api.dart';
import 'film.dart';

class SwapiList extends StatefulWidget {
  final Swapi swapi;

  const SwapiList({
    this.swapi,
    Key key,
  }) : super(key: key);

  @override
  _SwapiListState createState() => _SwapiListState();
}

class _SwapiListState extends State<SwapiList>{
  Swapi _swapi;
  var data = List.empty();
  SWAPI _api = SWAPI();
  var _size = 0;
  int _selectedIndex = 0;

  @override
  initState() {
    _swapi = widget.swapi;
    _api.getRawDataFromURL(widget.swapi.url).then( (result) {
      if(result.statusCode==200){
        setState(() {
          log('Consulta efetuado com sucesso!!!');
          data = jsonDecode(result.body);
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if ((data != null) && (data.length > 0)) {
      return Scaffold(
        appBar: AppBar( title: Text(widget.swapi.name)),
        body: ListView.builder(
          padding: new EdgeInsets.all(8.0),
          itemBuilder: (BuildContext context, int index) => listEntry(context, data[index]),
          itemCount: data.length,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator
                .of(context)
                .push(new MaterialPageRoute(builder: (context) => getFormDetails(true)))
                .whenComplete(
                _api.getRawDataFromURL(widget.swapi.url).then( (result) {
                  if(result.statusCode==200){
                    setState(() {
                      log('Consulta efetuado com sucesso!!!');
                      data = jsonDecode(result.body);
                    });
                  }
                })
            );
          },
          tooltip: 'Add',
          child: new Icon(Icons.add)
        ),
      );
    }
  }

  Widget listEntry(context, item){

    if(item['loading']!= null){

      return Padding(
        padding: EdgeInsets.all(40.0),
        child: Text(item['name'], textAlign: TextAlign.center, style: TextStyle(fontSize: 20.0))
      );
    } else {
      var children = <Widget>[];
      item.forEach( (k,v){
        bool url = v.toString().indexOf("http") != -1;
        bool date = (k=="created" || k=="edited");
        if(v!=null && !url && !date){
          children.add(ListTile(title: Text('$k: $v')));
        }
      });

      return ListTile(
        leading: getListIcon(),
        title: ExpansionTile(
          title: Text(item[getTitleField()] ?? 'Hello'),
          trailing: IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator
                  .of(context)
                  .push(new MaterialPageRoute(builder: (context) => getFormDetails(false, item)))
                  .whenComplete(
                    _api.getRawDataFromURL(widget.swapi.url).then( (result) {
                      if(result.statusCode==200){
                        setState(() {
                          log('Consulta efetuado com sucesso!!!');
                          data = jsonDecode(result.body);
                        });
                      }
                    })
              );
            },
          ),
          children: children,
        ),
      );
    }

  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  StatefulWidget getFormDetails(bool addFilm, [item]) {
    (addFilm) ? Film.newMap() : item;
    switch(widget.swapi.name){
      case 'Peoples':
        // return SwapiPeopleDetails(
        //   film: item,
        //   onChanged: (value) => widget.onPeopleChanged(value),
        // );
      case 'Planets':
        // return SwapiPeopleDetails(
        //   film: item,
        //   onChanged: (value) => widget.onPeopleChanged(value),
        // );
      case 'Films':
        return SwapiFilmDetails(
          addFilm: addFilm,
          film: item,
        );
      case 'Species':
        // return SwapiPeopleDetails(
        //   film: item,
        //   onChanged: (value) => widget.onPeopleChanged(value),
        // );
      case 'Vehicles':
        // return SwapiPeopleDetails(
        //   film: item,
        //   onChanged: (value) => widget.onPeopleChanged(value),
        // );
      case 'Starships':
        // return SwapiPeopleDetails(
        //   film: item,
        //   onChanged: (value) => widget.onPeopleChanged(value),
        // );
    }
  }

  String getTitleField() {
    switch(widget.swapi.name){
      case 'Films': return "title";
      default: return "name";
    }
  }

  Icon getListIcon() {
    switch(widget.swapi.name){
      case 'Peoples': return Icon(Icons.person);
      case 'Planets': return Icon(Icons.public);
      case 'Films': return Icon(Icons.local_movies);
      case 'Species': return Icon(Icons.android);
      case 'Vehicles': return Icon(Icons.motorcycle);
      case 'Starships': return Icon(Icons.flight_land);
      default: return Icon(Icons.description);
    }
  }
}
