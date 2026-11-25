import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/karyawan.dart';
import 'gaji_api.dart';

final gajiApiProvider = Provider<GajiApi>((ref) => GajiApi());

// (a) FutureProvider: daftar gaji 10 karyawan
final daftarGajiProvider = FutureProvider<List<Karyawan>>(
  (ref) => ref.watch(gajiApiProvider).fetchDaftarGaji(),
);

// (d) family: detail gaji satu karyawan berdasarkan NIK
final gajiDetailProvider = FutureProvider.family<Karyawan, String>(
  (ref, nik) => ref.watch(gajiApiProvider).fetchDetail(nik),
);

// (b) State penggajian yang immutable
class PenggajianState {
  final List<String> diproses; // NIK yang sudah diproses
  final bool isProcessing;

  const PenggajianState({
    this.diproses = const [],
    this.isProcessing = false,
  });

  int get totalDiproses => diproses.length;

  PenggajianState copyWith({List<String>? diproses, bool? isProcessing}) {
    return PenggajianState(
      diproses: diproses ?? this.diproses,
      isProcessing: isProcessing ?? this.isProcessing,
    );
  }
}

// (b) Notifier (Riverpod 3), pengganti StateNotifier pada modul
class PenggajianNotifier extends Notifier<PenggajianState> {
  @override
  PenggajianState build() => const PenggajianState(); // state awal

  Future<void> prosesSemua(List<Karyawan> daftar) async {
    state = state.copyWith(isProcessing: true);
    await Future.delayed(const Duration(seconds: 1)); // simulasi proses
    if (!ref.mounted) return; // provider mungkin sudah dibuang
    state = PenggajianState(
      diproses: [for (final k in daftar) k.nik],
      isProcessing: false,
    );
  }

  void reset() => state = const PenggajianState();
}

final penggajianProvider =
    NotifierProvider<PenggajianNotifier, PenggajianState>(
      PenggajianNotifier.new,
    );