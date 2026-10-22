import 'package:flutter/material.dart';

import '../models/tour_package.dart';

/// Hasil pemesanan yang dikembalikan lewat Navigator.pop().
class BookingResult {
  final String name;
  final int participants;
  final DateTime departureDate;
  final int totalPrice;

  const BookingResult({
    required this.name,
    required this.participants,
    required this.departureDate,
    required this.totalPrice,
  });

  String get formattedDate {
    final d = departureDate;
    return '${d.day.toString().padLeft(2, '0')}/'
        '${d.month.toString().padLeft(2, '0')}/${d.year}';
  }
}

class BookingScreen extends StatefulWidget {
  final TourPackage tourPackage;
  const BookingScreen({super.key, required this.tourPackage});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _participantsCtrl = TextEditingController();
  DateTime? _date;
  bool _dateError = false;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _participantsCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _date ?? now.add(const Duration(days: 1)),
      firstDate: now,
      lastDate: now.add(const Duration(days: 365)),
    );
    if (picked != null) {
      setState(() {
        _date = picked;
        _dateError = false;
      });
    }
  }

  bool get _isDirty =>
      _nameCtrl.text.isNotEmpty ||
      _participantsCtrl.text.isNotEmpty ||
      _date != null;

  void _submit() {
    final valid = _formKey.currentState!.validate();
    setState(() => _dateError = _date == null);
    if (!valid || _date == null) return;

    final participants = int.parse(_participantsCtrl.text);
    final result = BookingResult(
      name: _nameCtrl.text.trim(),
      participants: participants,
      departureDate: _date!,
      totalPrice: widget.tourPackage.price * participants,
    );
    // Kembalikan hasil ke Detail Screen.
    Navigator.pop(context, result);
  }

  Future<bool> _confirmExit() async {
    final leave = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Batalkan Pemesanan?'),
        content: const Text(
            'Data yang sudah Anda isi akan hilang jika keluar dari halaman ini.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Tetap di Sini'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Ya, Keluar'),
          ),
        ],
      ),
    );
    return leave ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final dateText = _date == null
        ? 'Pilih tanggal keberangkatan'
        : '${_date!.day.toString().padLeft(2, '0')}/'
            '${_date!.month.toString().padLeft(2, '0')}/${_date!.year}';

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        final leave = await _confirmExit();
        if (leave && mounted) Navigator.pop(context);
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Form Pemesanan')),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  child: ListTile(
                    leading: const Icon(Icons.card_travel),
                    title: Text(widget.tourPackage.title),
                    subtitle:
                        Text('${widget.tourPackage.formattedPrice} / orang'),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _nameCtrl,
                  textCapitalization: TextCapitalization.words,
                  decoration: const InputDecoration(
                    labelText: 'Nama Lengkap',
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                  ),
                  validator: (v) => (v == null || v.trim().isEmpty)
                      ? 'Nama wajib diisi'
                      : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _participantsCtrl,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Jumlah Peserta',
                    prefixIcon: Icon(Icons.group),
                    border: OutlineInputBorder(),
                  ),
                  validator: (v) {
                    final n = int.tryParse(v ?? '');
                    if (n == null || n < 1) return 'Minimal 1 peserta';
                    if (n > 50) return 'Maksimal 50 peserta';
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                InkWell(
                  onTap: _pickDate,
                  child: InputDecorator(
                    decoration: InputDecoration(
                      labelText: 'Tanggal Keberangkatan',
                      prefixIcon: const Icon(Icons.calendar_today),
                      border: const OutlineInputBorder(),
                      errorText: _dateError ? 'Tanggal wajib dipilih' : null,
                    ),
                    child: Text(dateText),
                  ),
                ),
                const SizedBox(height: 28),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14)),
                    onPressed: _submit,
                    child: const Text('Konfirmasi Pemesanan'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
