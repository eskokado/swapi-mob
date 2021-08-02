import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:swapi_mob/api.dart';

import 'film.dart';

class SwapiFilmDetails extends StatefulWidget {
  final addFilm;
  final film;

  const SwapiFilmDetails({
    this.addFilm,
    this.film,
    Key key,
  }) : super(key: key);

  @override
  SwapiFilmDetailsState createState() => SwapiFilmDetailsState();
}

class SwapiFilmDetailsState extends State<SwapiFilmDetails> {
  var _film;
  final TextEditingController _filmIdController = TextEditingController();
  final TextEditingController _producerController = TextEditingController();
  final TextEditingController _episodeIdController = TextEditingController();
  final TextEditingController _openingCrawlController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _directorController = TextEditingController();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _createdController = TextEditingController();
  final TextEditingController _editedController = TextEditingController();
  final TextEditingController _urlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SWAPI _api = SWAPI();
    return Scaffold(
      appBar: AppBar(
        title: Text((widget.addFilm) ? 'Add' : 'Edit ' + _film['title']),
        backgroundColor: Colors.green[700],
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 0.0, 8.0, 0.0),
            child: IconButton(
              icon: const Icon(Icons.save, size: 30.0),
              onPressed: () {
                if (widget.addFilm) {
                  _api.create(_film, 'film').then(
                          (value) => _film = value
                  );
                } else {
                  _api.update(_film, 'film').then(
                          (value) => _film = value
                  );
                }
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: _detailsBody(),
      ),
      floatingActionButton: Visibility(
        child: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                // retorna um objeto do tipo Dialog
                return AlertDialog(
                  title: new Text('Delete Films?'),
                  content: new Text('Are you sure you want to delete movie.'),
                  actions: <Widget>[
                    FlatButton(
                      textColor: Color(0xFF6200EE),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('CANCEL'),
                    ),
                    FlatButton(
                      textColor: Color(0xFF6200EE),
                      onPressed: () async {
                        await _api.delete(_film['id'], 'film');
                        Navigator.of(context).pop();
                      },
                      child: Text('ACCEPT'),
                    ),
                  ],
                );
              },
            );
          },
          tooltip: 'Remove',
          child: Icon(Icons.delete),
        ),
        visible: (!widget.addFilm),
      ),
    );
  }

  @override
  void initState() {
    if (widget.addFilm) {
      _film = Film.newMap();
    } else {
      _film = widget.film;
    }
    _filmIdController.text = _film['filmId'].toString();
    _producerController.text = _film['producer'];
    _episodeIdController.text = _film['episodeId'].toString();
    _openingCrawlController.text = _film['openingCrawl'];
    _titleController.text = _film['title'];
    _directorController.text = _film['director'];
    _idController.text = _film['id'];
    _createdController.text = _film['created'];
    _editedController.text = _film['edited'];
    _urlController.text = _film['url'];
    return super.initState();
  }

  Widget _detailsBody() {
    return ListView(
      padding: const EdgeInsets.fromLTRB(24.0, 12.0, 24.0, 12.0),
      children: [
        _FilmIdTextField(
          controller: _filmIdController,
          onChanged: (value) {
            setState(() {
              _film['filmId'] = int.parse(value);
            });
          },
        ),
        _ProducerTextField(
          controller: _producerController,
          onChanged: (value) {
            setState(() {
              _film['producer'] = value;
            });
          },
        ),
        _EpisodeIdTextField(
          controller: _episodeIdController,
          onChanged: (value) {
            setState(() {
              _film['episodeId'] = value;
            });
          },
        ),
        _OpeningCrawlTextField(
          controller: _openingCrawlController,
          onChanged: (value) {
            setState(() {
              _film['openingCrawl'] = value;
            });
          },
        ),
        _TitleTextField(
          controller: _titleController,
          onChanged: (value) {
            setState(() {
              _film['title'] = value;
            });
          },
        ),
        _DirectorTextField(
          controller: _directorController,
          onChanged: (value) {
            setState(() {
              _film['director'] = value;
            });
          },
        ),
      ],
    );
  }
}

class _FilmIdTextField extends StatelessWidget {
  final TextEditingController controller;

  final ValueChanged<String> onChanged;
  const _FilmIdTextField({
    this.controller,
    this.onChanged,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 16.0),
      child: TextField(
        decoration: const InputDecoration(
          labelText: 'Film Id',
          labelStyle: TextStyle(fontSize: 18.0),
        ),
        style: const TextStyle(fontSize: 20.0, color: Colors.black87),
        maxLines: null,
        autocorrect: true,
        controller: controller,
        onChanged: (value) {
          onChanged(value);
        },
      ),
    );
  }
}

class _ProducerTextField extends StatelessWidget {
  final TextEditingController controller;

  final ValueChanged<String> onChanged;
  const _ProducerTextField({
    this.controller,
    this.onChanged,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 16),
      child: TextField(
        decoration: const InputDecoration(
          labelText: 'Producer',
          labelStyle: TextStyle(fontSize: 18),
        ),
        style: const TextStyle(fontSize: 20, color: Colors.black87),
        autocorrect: true,
        controller: controller,
        onChanged: (value) {
          onChanged(value);
        },
      ),
    );
  }
}

class _EpisodeIdTextField extends StatelessWidget {
  final TextEditingController controller;

  final ValueChanged<String> onChanged;
  const _EpisodeIdTextField({
    this.controller,
    this.onChanged,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 16),
      child: TextField(
        decoration: const InputDecoration(
          labelText: 'Episode Id',
          labelStyle: TextStyle(fontSize: 18),
        ),
        style: const TextStyle(fontSize: 20, color: Colors.black87),
        autocorrect: true,
        controller: controller,
        onChanged: (value) {
          onChanged(value);
        },
      ),
    );
  }
}

class _OpeningCrawlTextField extends StatelessWidget {
  final TextEditingController controller;

  final ValueChanged<String> onChanged;
  const _OpeningCrawlTextField({
    this.controller,
    this.onChanged,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 16),
      child: TextField(
        decoration: const InputDecoration(
          labelText: 'Opening Crawl',
          labelStyle: TextStyle(fontSize: 18),
        ),
        style: const TextStyle(fontSize: 20, color: Colors.black87),
        autocorrect: true,
        controller: controller,
        onChanged: (value) {
          onChanged(value);
        },
      ),
    );
  }
}

class _TitleTextField extends StatelessWidget {
  final TextEditingController controller;

  final ValueChanged<String> onChanged;
  const _TitleTextField({
    this.controller,
    this.onChanged,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 16),
      child: TextField(
        decoration: const InputDecoration(
          labelText: 'Title',
          labelStyle: TextStyle(fontSize: 18),
        ),
        style: const TextStyle(fontSize: 20, color: Colors.black87),
        autocorrect: true,
        controller: controller,
        onChanged: (value) {
          onChanged(value);
        },
      ),
    );
  }
}

class _DirectorTextField extends StatelessWidget {
  final TextEditingController controller;

  final ValueChanged<String> onChanged;
  const _DirectorTextField({
    this.controller,
    this.onChanged,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 16),
      child: TextField(
        decoration: const InputDecoration(
          labelText: 'Director',
          labelStyle: TextStyle(fontSize: 18),
        ),
        style: const TextStyle(fontSize: 20, color: Colors.black87),
        autocorrect: true,
        controller: controller,
        onChanged: (value) {
          onChanged(value);
        },
      ),
    );
  }
}


