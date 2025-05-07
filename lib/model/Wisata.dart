class Wisata {
  int id;
  String? name;
  double? rating;
  String? kategori;
  List<String?> subKategori;
  int budjet;
  Map<String, int>? aksesibilitas;
  Map<String, dynamic>? waktuKunjungan;
  Map<String, dynamic>? rekomendasiUntuk;
  String lokasi;

  Wisata({
    required this.id,
    required this.name,
    required this.rating,
    required this.kategori,
    required this.subKategori,
    required this.budjet,
    this.aksesibilitas,
    required this.waktuKunjungan,
    required this.rekomendasiUntuk,
    required this.lokasi,
  });

  factory Wisata.fromJson(Map<String, dynamic> json) {
    return Wisata(
      id: json['id'] as int,
      name: json['nama'] as String?,
      rating: json['rating'] as double?,
      subKategori:
          json['subKategori'] != null
              ? List<String?>.from(json['subKategori'])
              : <String?>[],
      kategori: json['kategori'] as String?,
      budjet:
          json['budget'] is int
              ? json['budget']
              : int.parse(json['budget'].toString()),
      aksesibilitas:
          json['aksesibilitas'] != null
              ? Map<String, int>.from(json['aksesibilitas'])
              : null,
      waktuKunjungan: Map<String, dynamic>.from(json['waktu_kunjungan']),
      rekomendasiUntuk: Map<String, dynamic>.from(
        json['direkomendasikan_untuk'],
      ),
      lokasi: json['lokasi'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'kategori': kategori,
      'subKategori': subKategori,
      'budjet': budjet,
      'aksesibilitas': aksesibilitas,
      'waktu_kunjungan': waktuKunjungan,
      'direkomendasikan_untuk': rekomendasiUntuk,
      'lokasi': lokasi,
    };
  }
}
