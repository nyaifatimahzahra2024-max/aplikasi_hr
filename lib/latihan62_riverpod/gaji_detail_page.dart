import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/karyawan.dart';
import 'gaji_providers.dart';

class GajiDetailPage extends ConsumerWidget {
  const GajiDetailPage({super.key, required this.nik});

  final String nik;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailAsync = ref.watch(gajiDetailProvider(nik));
    final sudah = ref.watch(
      penggajianProvider.select((s) => s.diproses.contains(nik)),
    );

    return Scaffold(
      appBar: AppBar(title: Text('Detail Gaji $nik')),
      body: detailAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('$error')),
        data: (k) => ListView(
          padding: const EdgeInsets.all(16),
          children: [
            ListTile(title: const Text('Nama'), subtitle: Text(k.nama)),
            ListTile(title: const Text('Divisi'), subtitle: Text(k.divisi)),
            ListTile(
              title: const Text('Gaji Pokok'),
              subtitle: Text(formatRupiah(k.gajiPokok)),
            ),
            ListTile(
              title: const Text('Status'),
              subtitle: Text(sudah ? 'Sudah diproses' : 'Belum diproses'),
            ),
          ],
        ),
      ),
    );
  }
}