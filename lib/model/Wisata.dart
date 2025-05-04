class Wisata {
  String? id;
  String? name;
  List<String>? kategori;
  String? subKategori;
  String? budjet;
  List<String>? aksesbilitas;
  List<String>? waktuKunjungan;
  List<String>? rekomendasiUntuk;
  String? lokasi;


  Wisata({
    this.id,
    this.name,
    this.kategori,
    this.subKategori,
    this.budjet,
    this.aksesbilitas,
    this.waktuKunjungan,
    this.rekomendasiUntuk,
    this.lokasi,
  });

  Wisata.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    kategori = json['kategori'].cast<String>();
    subKategori = json['subKategori'];
    budjet = json['budjet'];
    aksesbilitas = json['aksesbilitas'].cast<String>();
    waktuKunjungan = json['waktu_kunjungan'].cast<String>();
    rekomendasiUntuk = json['direkomendasikan_untuk'].cast<String>();
    lokasi = json['lokasi'];
  }
}