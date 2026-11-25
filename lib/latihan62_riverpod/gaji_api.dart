import 'dart:math';

import '../models/karyawan.dart';

class GajiApi {
  final _random = Random();

  // Simulasi HTTP: tunggu 2 detik, gagal acak sekitar 25%
  Future<List<Karyawan>> fetchDaftarGaji() async {
    await Future.delayed(const Duration(seconds: 2));
    if (_random.nextInt(4) == 0) {
      throw Exception('Gagal terhubung ke server penggajian');
    }
    return dummyKaryawan;
  }

  Future<Karyawan> fetchDetail(String nik) async {
    await Future.delayed(const Duration(seconds: 1));
    final karyawan = cariKaryawan(nik);
    if (karyawan == null) throw Exception('Karyawan $nik tidak ditemukan');
    return karyawan;
  }
}