import 'package:flutter/material.dart';
import '../models/registration_ticket.dart';

class RegisteredTicketsScreen extends StatelessWidget {
  const RegisteredTicketsScreen({
    super.key,
    required this.tickets,
    required this.onCancel,
  });

  final List<RegistrationTicket> tickets;
  final ValueChanged<RegistrationTicket> onCancel;

  Future<void> _confirmCancel(BuildContext context, RegistrationTicket ticket) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        icon: const Icon(Icons.warning_amber_rounded, color: Colors.deepOrange, size: 34),
        title: const Text('Batalkan tiket?'),
        content: Text('Tiket untuk "${ticket.eventTitle}" akan dihapus dari daftar aktif. Tindakan ini tidak dapat dibatalkan.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Kembali'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Ya, batalkan'),
          ),
        ],
      ),
    );
    if (confirmed == true) onCancel(ticket);
  }

  @override
  Widget build(BuildContext context) {
    if (tickets.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.confirmation_number_outlined, size: 72, color: Theme.of(context).colorScheme.primary),
              const SizedBox(height: 14),
              Text('Belum ada tiket terdaftar',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800)),
              const SizedBox(height: 6),
              const Text('Pilih seminar dan tekan “Daftar sekarang” untuk membuat tiket.'),
            ],
          ),
        ),
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: tickets.length,
      itemBuilder: (context, index) {
        final ticket = tickets[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Dismissible(
            key: ValueKey(ticket.id),
            direction: DismissDirection.endToStart,
            background: Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 22),
              decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(18)),
              child: const Icon(Icons.delete_outline, color: Colors.white, size: 30),
            ),
            confirmDismiss: (_) async {
              await _confirmCancel(context, ticket);
              return false;
            },
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Icon(Icons.confirmation_number_outlined),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(ticket.eventTitle, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800)),
                          const SizedBox(height: 5),
                          Text(ticket.name),
                          Text('NIM: ${ticket.nim}'),
                          Text('Tipe: ${ticket.participantType} • Kit: ${ticket.kitPackage}'),
                          Text('Kehadiran: ${ticket.attendanceDate.day}/${ticket.attendanceDate.month}/${ticket.attendanceDate.year}'),
                          if (ticket.donation > 0) Text('Donasi: Rp${ticket.donation}'),
                          const SizedBox(height: 8),
                          OutlinedButton.icon(
                            onPressed: () => _confirmCancel(context, ticket),
                            icon: const Icon(Icons.delete_outline),
                            label: const Text('Batalkan tiket'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
