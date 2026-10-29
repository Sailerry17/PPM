import 'package:flutter/material.dart';
import '../data/sample_events.dart';
import '../models/event_item.dart';
import '../models/registration_ticket.dart';
import '../widgets/event_card.dart';
import '../widgets/filter_bottom_sheet.dart';
import '../widgets/venue_map_viewer.dart';
import 'event_registration_screen.dart';
import 'registered_tickets_screen.dart';

class HomeEventsScreen extends StatefulWidget {
  const HomeEventsScreen({super.key});

  @override
  State<HomeEventsScreen> createState() => _HomeEventsScreenState();
}

class _HomeEventsScreenState extends State<HomeEventsScreen> {
  int _tabIndex = 0;
  String _category = 'Semua';
  final List<RegistrationTicket> _tickets = [];

  List<EventItem> get _filteredEvents => sampleEvents
      .where((event) => _category == 'Semua' || event.category == _category)
      .toList();

  Future<void> _register(EventItem event) async {
    final ticket = await Navigator.push<RegistrationTicket>(
      context,
      MaterialPageRoute(builder: (_) => EventRegistrationScreen(event: event)),
    );
    if (!mounted || ticket == null) return;
    setState(() => _tickets.insert(0, ticket));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Pendaftaran ${ticket.eventTitle} berhasil!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      _buildSeminarTab(),
      _buildGalleryTab(),
      RegisteredTicketsScreen(
        tickets: _tickets,
        onCancel: (ticket) => setState(() => _tickets.removeWhere((t) => t.id == ticket.id)),
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text('NusaEvent Hub'),
        actions: [
          IconButton(
            tooltip: 'Filter kategori',
            onPressed: () async {
              final selected = await showCategoryFilter(context, _category);
              if (selected != null) setState(() => _category = selected);
            },
            icon: const Icon(Icons.filter_list),
          ),
          const SizedBox(width: 6),
        ],
      ),
      body: SafeArea(child: IndexedStack(index: _tabIndex, children: pages)),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _tabIndex,
        onDestinationSelected: (index) => setState(() => _tabIndex = index),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.event_note), label: 'Seminar'),
          NavigationDestination(icon: Icon(Icons.photo_library_outlined), label: 'Galeri & Denah'),
          NavigationDestination(icon: Icon(Icons.confirmation_number_outlined), label: 'Tiket'),
        ],
      ),
    );
  }

  Widget _buildSeminarTab() {
    final events = _filteredEvents;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 18, 16, 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Temukan acara berikutnya',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800)),
              const SizedBox(height: 5),
              const Text('Seminar dan workshop teknologi untuk mengembangkan skill kamu.'),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: eventCategories.map((category) {
                  return ChoiceChip(
                    label: Text(category),
                    selected: _category == category,
                    onSelected: (_) => setState(() => _category = category),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
        Expanded(
          child: events.isEmpty
              ? const Center(child: Text('Tidak ada acara pada kategori ini.'))
              : ListView.builder(
                  padding: const EdgeInsets.fromLTRB(16, 4, 16, 18),
                  itemCount: events.length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: EventCard(
                      event: events[index],
                      onTap: () => _showEventDetails(events[index]),
                    ),
                  ),
                ),
        ),
      ],
    );
  }

  void _showEventDetails(EventItem event) {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(event.title, style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 10),
              Text(event.description),
              const SizedBox(height: 12),
              Text('${event.dateLabel} • ${event.time}'),
              Text(event.venue),
              const SizedBox(height: 18),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                    _register(event);
                  },
                  icon: const Icon(Icons.confirmation_number_outlined),
                  label: const Text('Daftar sekarang'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGalleryTab() {
    final colors = [
      const Color(0xFF6750A4), const Color(0xFF1976D2),
      const Color(0xFF00897B), const Color(0xFFC45132),
      const Color(0xFF6750A4), const Color(0xFF1976D2),
    ];
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text('Galeri acara', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800)),
        const SizedBox(height: 6),
        const Text('Poster contoh dibuat langsung dengan widget Flutter.'),
        const SizedBox(height: 14),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: sampleEvents.length,
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 230,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 0.78,
          ),
          itemBuilder: (context, index) {
            final event = sampleEvents[index];
            return Card(
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                onTap: () => _showEventDetails(event),
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [colors[index].withValues(alpha: 0.95), colors[index].withValues(alpha: 0.65)],
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.auto_awesome, color: Colors.white, size: 28),
                      const Spacer(),
                      Text(event.category.toUpperCase(),
                          style: const TextStyle(color: Colors.white70, letterSpacing: 1.2, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 7),
                      Text(event.title,
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w800)),
                      const SizedBox(height: 10),
                      const Text('NUSAEVENT HUB', style: TextStyle(color: Colors.white70, fontSize: 10, letterSpacing: 1.1)),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 24),
        Text('Denah venue', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800)),
        const SizedBox(height: 6),
        const Text('Cubit untuk memperbesar atau geser denah untuk melihat area lainnya.'),
        const SizedBox(height: 12),
        const SizedBox(height: 430, child: VenueMapViewer()),
        const SizedBox(height: 10),
        const Text('Catatan: denah ini merupakan ilustrasi untuk kebutuhan praktikum.'),
      ],
    );
  }
}
