class Film {
  final int filmId;
  final String producer;
  final int episodeId;
  final String openingCrawl;
  final String title;
  final String director;
  final String id;
  final String created;
  final String edited;
  final String url;

  const Film({
    this.filmId,
    this.producer,
    this.episodeId,
    this.openingCrawl,
    this.title,
    this.director,
    this.id,
    this.created,
    this.edited,
    this.url,
  });

  Film copyWith({
    int filmId,
    String producer,
    int episodeId,
    String openingCrawl,
    String title,
    String director,
    String id,
    String created,
    String edited,
    String url,
  }) {
    return Film(
      filmId: filmId ?? this.filmId,
      producer: producer ?? this.producer,
      episodeId: episodeId ?? this.episodeId,
      openingCrawl: openingCrawl ?? this.openingCrawl,
      title: title ?? this.title,
      director: director ?? this.director,
      id: id ?? this.id,
      created: created ?? this.created,
      edited: edited ?? this.edited,
      url: url ?? this.url
    );
  }

  static Film fromJson(data) {
    return Film(
        filmId: data['filmId'],
        producer: data['producer'],
        episodeId: data['episodeId'],
        openingCrawl: data['openingCrawl'],
        title: data['title'],
        director: data['director'],
        id: data['id'],
        created: data['created'],
        edited: data['edited'],
        url: data['url'],
    );
  }

  static dynamic newMap() {
    Map<String, dynamic> map = {
      'filmId': 0,
      'producer': '',
      'episodeId': 0,
      'openingCrawl': '',
      'title': '',
      'director': '',
      'id': '',
      'created': '',
      'edited': '',
      'url': '',
    };
    return map;
  }

}