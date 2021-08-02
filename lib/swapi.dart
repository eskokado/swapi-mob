class Swapi {
  final String id;
  final String name;
  final String url;

  const Swapi({
    this.id,
    this.name,
    this.url,
  });

  Swapi copyWith({
    String id,
    String name,
    String url,
  }) {
    return Swapi(
      id: id ?? this.id,
      name: name ?? this.name,
      url: url ?? this.url
    );
  }

  static Swapi fromJson(data) {
    return Swapi(
      id: data['id'],
      name: data['name'],
      url: data['url'],
    );
  }

}