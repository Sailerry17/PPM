import 'package:flutter/material.dart';
import '../models/event_item.dart';
import '../models/registration_ticket.dart';

class EventRegistrationScreen extends StatefulWidget {
  const EventRegistrationScreen({super.key, required this.event});
  final EventItem event;

  @override
  State<EventRegistrationScreen> createState() => _EventRegistrationScreenState();
}

class _EventRegistrationScreenState extends State<EventRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _nimController = TextEditingController();
  final _emailController = TextEditingController();
  final _whatsappController = TextEditingController();

  String _participantType = 'Mahasiswa';
  String _kitPackage = 'Standard';
  DateTime? _attendanceDate;
  int _donation = 0;
  bool _agreed = false;
  bool _loading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _nimController.dispose();
    _emailController.dispose();
    _whatsappController.dispose();
    super.dispose();
  }

  Future<void> _chooseDate() async {
    final today = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _attendanceDate ?? today,
      firstDate: today,
      lastDate: DateTime(today.year + 2),
      helpText: 'Pilih tanggal kehadiran',
    );
    if (picked != null) setState(() => _attendanceDate = picked);
  }

  Future<void> _submit() async {
    final valid = _formKey.currentState?.validate() ?? false;
    if (!valid) return;
    if (_attendanceDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Silakan pilih tanggal kehadiran.')),
      );
      return;
    }
    if (!_agreed) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Persetujuan tata tertib wajib dicentang.')),
      );
      return;
    }
    setState(() => _loading = true);
    await Future<void>.delayed(const Duration(milliseconds: 900));
    if (!mounted) return;
    final ticket = RegistrationTicket(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      eventId: widget.event.id,
      eventTitle: widget.event.title,
      name: _nameController.text.trim(),
      nim: _nimController.text.trim(),
      email: _emailController.text.trim(),
      whatsapp: _whatsappController.text.trim(),
      participantType: _participantType,
      attendanceDate: _attendanceDate!,
      kitPackage: _kitPackage,
      donation: _donation,
      createdAt: DateTime.now(),
    );
    Navigator.pop(context, ticket);
  }

  String? _required(String? value, String label) =>
      value == null || value.trim().isEmpty ? '$label wajib diisi.' : null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Formulir Pendaftaran')),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(18),
            children: [
              Text(widget.event.title,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800)),
              const SizedBox(height: 6),
              Text('${widget.event.dateLabel} • ${widget.event.venue}'),
              const SizedBox(height: 20),
              TextFormField(
                controller: _nameController,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(labelText: 'Nama lengkap', prefixIcon: Icon(Icons.person_outline)),
                validator: (v) {
                  final error = _required(v, 'Nama lengkap');
                  if (error != null) return error;
                  if (v!.trim().length < 3) return 'Nama minimal 3 karakter.';
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _nimController,
                decoration: const InputDecoration(labelText: 'NIM / nomor identitas', prefixIcon: Icon(Icons.badge_outlined)),
                validator: (v) {
                  final error = _required(v, 'NIM');
                  if (error != null) return error;
                  if (v!.trim().length < 5) return 'NIM minimal 5 karakter.';
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(labelText: 'Email', prefixIcon: Icon(Icons.email_outlined)),
                validator: (v) {
                  final error = _required(v, 'Email');
                  if (error != null) return error;
                  if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(v!.trim())) return 'Format email tidak valid.';
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _whatsappController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(labelText: 'Nomor WhatsApp', prefixIcon: Icon(Icons.phone_android)),
                validator: (v) {
                  final error = _required(v, 'Nomor WhatsApp');
                  if (error != null) return error;
                  final digits = v!.replaceAll(RegExp(r'\D'), '');
                  if (digits.length < 10 || digits.length > 15) return 'Nomor WhatsApp harus 10–15 digit.';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _participantType,
                decoration: const InputDecoration(labelText: 'Tipe peserta'),
                items: const ['Mahasiswa', 'Dosen', 'Umum']
                    .map((v) => DropdownMenuItem(value: v, child: Text(v))).toList(),
                onChanged: (v) => setState(() => _participantType = v ?? 'Mahasiswa'),
              ),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: _chooseDate,
                icon: const Icon(Icons.calendar_month),
                label: Text(_attendanceDate == null
                    ? 'Pilih tanggal kehadiran'
                    : '${_attendanceDate!.day.toString().padLeft(2, '0')}/${_attendanceDate!.month.toString().padLeft(2, '0')}/${_attendanceDate!.year}'),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: _kitPackage,
                decoration: const InputDecoration(labelText: 'Paket seminar kit'),
                items: const ['Tanpa kit', 'Standard', 'Premium']
                    .map((v) => DropdownMenuItem(value: v, child: Text(v))).toList(),
                onChanged: (v) => setState(() => _kitPackage = v ?? 'Standard'),
              ),
              const SizedBox(height: 16),
              Text('Donasi sukarela', style: Theme.of(context).textTheme.titleMedium),
              Wrap(
                spacing: 8,
                children: [0, 10000, 25000, 50000].map((amount) {
                  return ChoiceChip(
                    label: Text(amount == 0 ? 'Tidak ada' : 'Rp${amount ~/ 1000} rb'),
                    selected: _donation == amount,
                    onSelected: (_) => setState(() => _donation = amount),
                  );
                }).toList(),
              ),
              const SizedBox(height: 12),
              CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                value: _agreed,
                onChanged: (v) => setState(() => _agreed = v ?? false),
                controlAffinity: ListTileControlAffinity.leading,
                title: const Text('Saya menyetujui tata tertib dan ketentuan acara.'),
              ),
              const SizedBox(height: 16),
              FilledButton(
                onPressed: _loading ? null : _submit,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 13),
                  child: _loading
                      ? const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                          SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white)),
                          SizedBox(width: 12),
                          Text('Memproses pendaftaran...'),
                        ])
                      : const Text('Daftar sekarang'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
