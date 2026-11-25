import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/karyawan.dart';
import 'gaji_detail_page.dart';
import 'gaji_providers.dart';

class PenggajianPage extends ConsumerWidget {
  const PenggajianPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final daftarAsync = ref.watch(daftarGajiProvider);
    final penggajian = ref.watch(penggajianProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Penggajian (${penggajian.totalDiproses} diproses)'),
        actions: [
          IconButton(
            tooltip: 'Refresh',
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.read(penggajianProvider.notifier).reset();
              ref.invalidate(daftarGajiProvider); // (e) ambil ulang data
            },
          ),
        ],
      ),
      body: daftarAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error_outline, color: Colors.red, size: 48),
              const SizedBox(height: 8),
              Text('$error', textAlign: TextAlign.center),
              const SizedBox(height: 16),
              FilledButton(
                onPressed: () => ref.invalidate(daftarGajiProvider),
                child: const Text('Coba Lagi'),
              ),
            ],
          ),
        ),
        data: (daftar) => ListView.builder(
          itemCount: daftar.length,
          itemBuilder: (context, index) {
            final k = daftar[index];
            final sudah = penggajian.diproses.contains(k.nik);
            return ListTile(
              leading: Icon(
                sudah ? Icons.check_circle : Icons.schedule,
                color: sudah ? Colors.green : null,
              ),
              title: Text(k.nama),
              subtitle: Text('${k.divisi} • ${formatRupiah(k.gajiPokok)}'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => GajiDetailPage(nik: k.nik),
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: FilledButton.icon(
            onPressed: !daftarAsync.hasValue || penggajian.isProcessing
                ? null
                : () => ref
                      .read(penggajianProvider.notifier)
                      .prosesSemua(daftarAsync.requireValue),
            icon: const Icon(Icons.payments),
            label: Text(
              penggajian.isProcessing ? 'Memproses...' : 'Proses Semua',
            ),
          ),
        ),
      ),
    );
  }
}