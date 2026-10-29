import 'package:flutter/material.dart';

class VenueMapViewer extends StatelessWidget {
  const VenueMapViewer({super.key});

  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      minScale: 0.7,
      maxScale: 4,
      boundaryMargin: const EdgeInsets.all(30),
      child: Container(
        width: 620,
        height: 430,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: const Color(0xFFEAF1F8),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFFB7C8D9)),
        ),
        child: Column(
          children: [
            Container(
              height: 62,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: const Color(0xFF102A43),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text('PINTU MASUK & REGISTRASI',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 14),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: const [
                        _VenueRoom(label: 'Ruang Workshop A', color: Color(0xFFD8E8FF)),
                        SizedBox(height: 12),
                        _VenueRoom(label: 'Ruang Workshop B', color: Color(0xFFD8E8FF)),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: const [
                        _VenueRoom(label: 'AUDITORIUM UTAMA', color: Color(0xFFC8EBDD)),
                        SizedBox(height: 12),
                        _VenueRoom(label: 'AREA PAMERAN / GALERI', color: Color(0xFFFFE7B8)),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      children: const [
                        _VenueRoom(label: 'Konsumsi', color: Color(0xFFF4D6D6)),
                        SizedBox(height: 12),
                        _VenueRoom(label: 'P3K', color: Color(0xFFF4D6D6)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            Container(
              height: 42,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text('JALUR KELUAR DARURAT  →',
                  style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFB3261E))),
            ),
          ],
        ),
      ),
    );
  }
}

class _VenueRoom extends StatelessWidget {
  const _VenueRoom({required this.label, required this.color});
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: double.infinity,
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFF9DB1C5)),
        ),
        child: Text(label, textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.w700)),
      ),
    );
  }
}
