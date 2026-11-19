import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/models/transaksi.dart';
import 'kas_view_model.dart';

class TambahTransaksiScreen extends StatefulWidget {
  const TambahTransaksiScreen({super.key});

  @override
  State<TambahTransaksiScreen> createState() => _TambahTransaksiScreenState();
}

class _TambahTransaksiScreenState extends State<TambahTransaksiScreen> {
  final _formKey = GlobalKey<FormState>();
  final _keteranganController = TextEditingController();
  final _nominalController = TextEditingController();
  JenisTransaksi _jenis = JenisTransaksi.pemasukan;

  @override
  void dispose() {
    _keteranganController.dispose();
    _nominalController.dispose();
    super.dispose();
  }

  void _simpan() {
    if (_formKey.currentState!.validate()) {
      final nominal = double.tryParse(_nominalController.text) ?? 0;
      final errorMsg = context.read<KasViewModel>().tambahTransaksi(
        _keteranganController.text,
        nominal,
        _jenis,
      );

      if (errorMsg != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(errorMsg)));
      } else {
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tambah Transaksi')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                key: const Key('keteranganField'),
                controller: _keteranganController,
                decoration: const InputDecoration(labelText: 'Keterangan'),
                validator: (val) => val == null || val.isEmpty ? 'Tidak boleh kosong' : null,
              ),
              TextFormField(
                key: const Key('nominalField'),
                controller: _nominalController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Nominal'),
                validator: (val) => val == null || val.isEmpty ? 'Tidak boleh kosong' : null,
              ),
              DropdownButtonFormField<JenisTransaksi>(
                key: const Key('jenisDropdown'),
                value: _jenis,
                items: JenisTransaksi.values
                    .map((j) => DropdownMenuItem(value: j, child: Text(j.name)))
                    .toList(),
                onChanged: (val) => setState(() => _jenis = val!),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                key: const Key('simpanButton'),
                onPressed: _simpan,
                child: const Text('Simpan'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
