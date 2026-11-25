import 'package:flutter/foundation.dart';

class CutiNotifier extends ChangeNotifier {
  // NIK karyawan yang mengajukan cuti (private)
  final List<String> _pengajuan = [];

  // Getter read-only
  List<String> get pengajuan => List.unmodifiable(_pengajuan);
  int get jumlah => _pengajuan.length;
  bool sudahMengajukan(String nik) => _pengajuan.contains(nik);

  void ajukan(String nik) {
    if (sudahMengajukan(nik)) return;
    _pengajuan.add(nik);
    notifyListeners(); // beri tahu semua widget yang mendengarkan
  }

  void batalkan(String nik) {
    if (_pengajuan.remove(nik)) notifyListeners();
  }
}