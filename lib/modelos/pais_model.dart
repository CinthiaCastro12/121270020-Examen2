class Pais {
  String commonName;
  String officialName;
  String nativeName;
  String region;
  String subregion;
  List<String> tld;  // Asegúrate de que esto sea una lista de strings
  List<String> borders;  // También debe ser una lista de strings

  Pais({
    required this.commonName,
    required this.officialName,
    required this.nativeName,
    required this.region,
    required this.subregion,
    required this.tld,
    required this.borders,
  });

  factory Pais.fromJson(Map<String, dynamic> json) {
    return Pais(
      commonName: json['name']['common'] ?? 'No disponible',
      officialName: json['name']['official'] ?? 'No disponible',
      nativeName: json['name']['nativeName']?.values.first['common'] ?? 'No disponible',
      region: json['region'] ?? 'No disponible',
      subregion: json['subregion'] ?? 'No disponible',
      tld: List<String>.from(json['tld'] ?? []),
      borders: List<String>.from(json['borders'] ?? []),
    );
  }
}
