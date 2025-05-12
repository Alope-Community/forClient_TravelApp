class Wisata {
  int id;
  String? nama;
  List<String?> subKategori;
  String? kategori;
  int budget;
  Map<String, int>? aksesibilitas;
  Map<String, dynamic>? waktuKunjungan;
  Map<String, dynamic>? direkomendasikanUntuk;
  String lokasi;
  List<dynamic> images;
  double? rating;

  Wisata({
    required this.id,
    required this.nama,
    required this.subKategori,
    required this.kategori,
    required this.budget,
    required this.aksesibilitas,
    required this.waktuKunjungan,
    required this.direkomendasikanUntuk,
    required this.lokasi,
    required this.images,
    required this.rating,
  });

  factory Wisata.fromJson(Map<String, dynamic> json) {
    return Wisata(
      id: json['id'] as int,
      nama: json['nama'] as String?,
      rating: json['rating'] as double?,
      subKategori:
          json['subKategori'] != null
              ? List<String?>.from(json['subKategori'])
              : <String?>[],
      kategori: json['kategori'] as String?,
      budget:
          json['budget'] is int
              ? json['budget']
              : int.parse(json['budget'].toString()),
      aksesibilitas:
          json['aksesibilitas'] != null
              ? Map<String, int>.from(json['aksesibilitas'])
              : null,
      waktuKunjungan: Map<String, dynamic>.from(json['waktu_kunjungan']),
      direkomendasikanUntuk: Map<String, dynamic>.from(
        json['direkomendasikan_untuk'],
      ),
      lokasi: json['lokasi'] as String,
      images: json['images'] as List<dynamic>
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama': nama,
      'kategori': kategori,
      'sub_kategori': subKategori,
      'budget': budget,
      'aksesibilitas': aksesibilitas,
      'waktu_kunjungan': waktuKunjungan,
      'direkomendasikan_untuk': direkomendasikanUntuk,
      'lokasi': lokasi,
    };
  }
}
