class Ulasan {
  final String nama;
  final int rating;
  final String komentar;

  Ulasan({
    required this.nama,
    required this.rating,
    required this.komentar,
  });

  factory Ulasan.fromJson(Map<String, dynamic> json) {
    return Ulasan(
      nama: json['nama'] as String,
      rating: json['rating'] as int,
      komentar: json['komentar'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nama': nama,
      'rating': rating,
      'komentar': komentar,
    };
  }
}

class Destination {
  int id;
  String? name;
  List<String?> subCategories;
  String? category;
  int budget;
  Map<String, int>? accessibility;
  Map<String, dynamic>? visitingTime;
  Map<String, dynamic>? recommendedFor;
  String location;
  List<dynamic> images;
  double? rating;
  String description;
  List<Ulasan>? ulasan;
  double latitude;
  double longitude;

  Destination({
    required this.id,
    required this.name,
    required this.subCategories,
    required this.category,
    required this.budget,
    required this.accessibility,
    required this.visitingTime,
    required this.recommendedFor,
    required this.location,
    required this.images,
    required this.rating,
    required this.description,
    required this.ulasan,
    required this.latitude,
    required this.longitude,
  });

  String get googleMapsUrl =>
      'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';

  factory Destination.fromJson(Map<String, dynamic> json) {
    return Destination(
      id: json['id'] as int,
      name: json['nama'] as String?,
      description: json['description'] as String? ?? '',
      rating: json['rating'] is int
          ? (json['rating'] as int).toDouble()
          : json['rating'] as double?,
      subCategories: json['subKategori'] != null
          ? List<String?>.from(json['subKategori'])
          : <String?>[],
      category: json['kategori'] as String?,
      budget: json['budget'] is int
          ? json['budget']
          : int.parse(json['budget'].toString()),
      accessibility: json['aksesibilitas'] != null
          ? Map<String, int>.from(json['aksesibilitas'])
          : null,
      visitingTime: Map<String, dynamic>.from(json['waktu_kunjungan']),
      recommendedFor:
          Map<String, dynamic>.from(json['direkomendasikan_untuk']),
      location: json['lokasi'] as String,
      images: json['images'] as List<dynamic>,
      ulasan: json['ulasan'] != null
          ? (json['ulasan'] as List)
              .map((ulasanJson) => Ulasan.fromJson(ulasanJson))
              .toList()
          : null,
      latitude: json['latitude'] is String
          ? double.parse(json['latitude'])
          : json['latitude'] as double,
      longitude: json['longitude'] is String
          ? double.parse(json['longitude'])
          : json['longitude'] as double,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama': name,
      'kategori': category,
      'sub_kategori': subCategories,
      'budget': budget,
      'aksesibilitas': accessibility,
      'waktu_kunjungan': visitingTime,
      'direkomendasikan_untuk': recommendedFor,
      'lokasi': location,
      'description': description,
      'ulasan': ulasan?.map((ulasan) => ulasan.toJson()).toList(),
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
