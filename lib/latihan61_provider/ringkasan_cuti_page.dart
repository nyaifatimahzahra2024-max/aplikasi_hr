import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/karyawan.dart';
import 'cuti_notifier.dart';

class RingkasanCutiPage extends StatelessWidget {
  const RingkasanCutiPage({super.key});

  @override
  Widget build(BuildContext context) {
    final daftarNik = context.watch<CutiNotifier>().pengajuan;

    return Scaffold(
      appBar: AppBar(title: Text('Ringkasan Cuti (${daftarNik.length})')),
      body: daftarNik.isEmpty
          ? const Center(child: Text('Belum ada pengajuan cuti'))
          : ListView.builder(
              itemCount: daftarNik.length,
              itemBuilder: (context, index) {
                final nik = daftarNik[index];
                final karyawan = cariKaryawan(nik);
                return ListTile(
                  leading: const Icon(Icons.event_busy),
                  title: Text(karyawan?.nama ?? nik),
                  subtitle: Text(nik),
                  trailing: IconButton(
                    tooltip: 'Batalkan',
                    icon: const Icon(Icons.close),
                    onPressed: () =>
                        context.read<CutiNotifier>().batalkan(nik),
                  ),
                );
              },
            ),
    );
  }
}