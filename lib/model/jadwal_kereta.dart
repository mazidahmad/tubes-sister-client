import 'dart:convert';

class JadwalKereta {
  JadwalKereta({
    required this.id,
    required this.namaKereta,
    required this.destinasi,
    required this.waktuKeberangkatan,
    required this.posisiTerakhir,
    required this.estimasiKedatangan,
  });

  final String id;
  final String namaKereta;
  final String destinasi;
  final String waktuKeberangkatan;
  final String posisiTerakhir;
  final String estimasiKedatangan;

  factory JadwalKereta.fromJson(String str) =>
      JadwalKereta.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory JadwalKereta.fromMap(Map<String, dynamic> json) => JadwalKereta(
        id: json["id"],
        namaKereta: json["nama_kereta"],
        destinasi: json["destinasi"],
        waktuKeberangkatan: json["waktu_keberangkatan"],
        posisiTerakhir: json["posisi_terakhir"],
        estimasiKedatangan: json["estimasi_kedatangan"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "nama_kereta": namaKereta,
        "destinasi": destinasi,
        "waktu_keberangkatan": waktuKeberangkatan,
        "posisi_terakhir": posisiTerakhir,
        "estimasi_kedatangan": estimasiKedatangan,
      };
}
