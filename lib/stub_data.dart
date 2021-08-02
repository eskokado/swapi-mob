import 'package:swapi_mob/swapi.dart';

class StubData {
  static const List<Swapi> swapis = [
    Swapi(
      id: '1',
      name: 'Films',
      url: 'http://10.0.2.2:5000/film',
    ),
    Swapi(
      id: '2',
      name: 'Peoples',
      url: 'http://10.0.2.2:5000/people',
    ),
    Swapi(
      id: '3',
      name: 'Planets',
      url: 'http://10.0.2.2:5000/planet',
    ),
    Swapi(
      id: '4',
      name: 'Species',
      url: 'http://10.0.2.2:5000/specie',
    ),
    Swapi(
      id: '5',
      name: 'Starship',
      url: 'http://10.0.2.2:5000/starship',
    ),
    Swapi(
      id: '6',
      name: 'Vehicles',
      url: 'http://10.0.2.2:5000/vehicle',
    ),
  ];
}