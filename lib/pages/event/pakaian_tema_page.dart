import 'package:flutter/material.dart';
import 'package:mesran_app/utils/themes.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PakaianTemaPage(),
    );
  }
}

class PakaianTemaPage extends StatefulWidget {
  @override
  _PakaianTemaPageState createState() => _PakaianTemaPageState();
}

class _PakaianTemaPageState extends State<PakaianTemaPage> {
  int _selectedIndex = 0;

  final List<Map<String, dynamic>> _items = [
    {'label': 'Formal', 'icon': Icons.checkroom},
    {'label': 'Kasual', 'icon': Icons.safety_check},
    {'label': 'Olahraga', 'icon': Icons.sports_basketball},
    {'label': 'Tradisional', 'icon': Icons.attractions},
    {'label': 'Horror', 'icon': Icons.emoji_objects},
    {'label': 'Anime', 'icon': Icons.child_friendly},
  ];

  void _onSave() {
    final selectedTheme = _items[_selectedIndex]['label'];
    print('Selected theme: $selectedTheme');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                context.go('/events/create'); // Navigasi kembali
              },
              child: const Icon(Icons.chevron_left, color: Colors.black),
            ),
            const SizedBox(width: 8),
            Text("Pakaian dan Tema", style: headingTwoSemiBold),
          ],
        ),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Pilih Tema', style: titleOneMedium),
            const SizedBox(height: 8),
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Masukkan tema',
                hintStyle: titleOneRegular?.copyWith(color: neutral40) ??
                    TextStyle(color: Colors.grey),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                      color: neutral20), // Warna abu-abu saat tidak aktif
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                      color: primaryBase), // Warna abu-abu saat aktif (fokus)
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text('Pilih Pakaian', style: titleOneMedium),
            const SizedBox(height: 8),
            Expanded(
              child: GridView.builder(
                itemCount: _items.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 2.5,
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedIndex = index;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color:
                              _selectedIndex == index ? primaryBase : neutral20,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            _items[index]['icon'] as IconData,
                            color: _selectedIndex == index
                                ? primaryBase
                                : neutralBase,
                          ),
                          const SizedBox(height: 4),
                          Text(_items[index]['label'] as String,
                              style: titleOneMedium),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryBase,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: _onSave,
                child: Text(
                  'Simpan',
                  style: titleOneSemiBold.copyWith(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
