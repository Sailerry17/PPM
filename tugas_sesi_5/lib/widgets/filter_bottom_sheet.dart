import 'package:flutter/material.dart';

const eventCategories = ['Semua', 'AI', 'Mobile', 'IoT', 'Cybersecurity'];

Future<String?> showCategoryFilter(BuildContext context, String selected) {
  return showModalBottomSheet<String>(
    context: context,
    showDragHandle: true,
    builder: (context) => SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Filter kategori', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            ...eventCategories.map(
              (category) => RadioListTile<String>(
                value: category,
                groupValue: selected,
                title: Text(category),
                onChanged: (value) => Navigator.pop(context, value),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
