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
  });

  factory Destination.fromJson(Map<String, dynamic> json) {
    return Destination(
      id: json['id'] as int,
      name: json['nama'] as String?,
      rating: json['rating'] as double?,
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
      recommendedFor: Map<String, dynamic>.from(json['direkomendasikan_untuk']),
      location: json['lokasi'] as String,
      images: json['images'] as List<dynamic>,
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
    };
  }
}
