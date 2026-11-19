import 'package:flutter_test/flutter_test.dart';
import 'package:wisata_sukabumi/main.dart';

void main() {
  testWidgets('beranda tampil', (tester) async {
    await tester.pumpWidget(const WisataApp());
    expect(find.text('Mau ke mana?'), findsOneWidget);
  });
}
