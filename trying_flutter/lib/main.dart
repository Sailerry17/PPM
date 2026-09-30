import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PPM Sesi 1',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
        ),
        useMaterial3: true,
      ),
      home: const CounterPage(),
    );
  }
}

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  int _counter = 0;

  // Data mahasiswa
  final String nama = "Adhitya Prahma Dwi Putra";
  final String nim = "20240040182";
  final String prodi = "Teknik Informatika";
  final String kelas = "TI24G";

  void _tambah() {
    setState(() {
      _counter++;
    });
  }

  void _kurang() {
    if (_counter == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Counter tidak boleh kurang dari 0!"),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    setState(() {
      _counter--;
    });
  }

  void _reset() {
    setState(() {
      _counter = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool genap = _counter % 2 == 0;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "PPM Sesi 1 - $nama ($nim)",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            // Kartu Identitas
            Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 35,
                      backgroundColor: Colors.indigo,
                      child: const Icon(
                        Icons.person,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),

                    const SizedBox(width: 20),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            nama,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 5),

                          Text("NIM: $nim"),
                          Text("Prodi: $prodi"),
                          Text("Kelas: $kelas"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 40),

            const Text(
              "COUNTER",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            // Angka Counter
            Text(
              "$_counter",
              style: TextStyle(
                fontSize: 80,
                fontWeight: FontWeight.bold,
                color: genap ? Colors.indigo : Colors.orange,
              ),
            ),

            const SizedBox(height: 10),

            // Status Genap / Ganjil
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                color: genap
                    ? Colors.indigo.withOpacity(0.1)
                    : Colors.orange.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                genap ? "Angka Genap" : "Angka Ganjil",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: genap ? Colors.indigo : Colors.orange,
                ),
              ),
            ),

            const SizedBox(height: 40),

            // Tombol + dan -
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: _kurang,
                  icon: const Icon(Icons.remove),
                  label: const Text("Kurang"),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25,
                      vertical: 15,
                    ),
                  ),
                ),

                const SizedBox(width: 20),

                ElevatedButton.icon(
                  onPressed: _tambah,
                  icon: const Icon(Icons.add),
                  label: const Text("Tambah"),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25,
                      vertical: 15,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Tombol Reset
            OutlinedButton.icon(
              onPressed: _reset,
              icon: const Icon(Icons.refresh),
              label: const Text("Reset"),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 35,
                  vertical: 15,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
