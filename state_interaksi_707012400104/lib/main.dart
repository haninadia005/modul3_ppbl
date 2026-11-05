import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // paket Provider
import 'models/keranjang_model.dart'; // model keranjang (ChangeNotifier)
import 'pages/halaman_keranjang.dart';
import 'pages/halaman_produk.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => KeranjangModel(), 
      child: const AplikasiKantin(),
    ),
  );
}
class AplikasiKantin extends StatelessWidget {
  const AplikasiKantin({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kantin Kampus',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const KerangkaUtama(),
    );
  }
}
class KerangkaUtama extends StatefulWidget {
  const KerangkaUtama({super.key});
  @override
  State<KerangkaUtama> createState() => KerangkaUtamaState();
}
class KerangkaUtamaState extends State<KerangkaUtama> {
  int _indeks = 0; // state lokal: tetap pakai setState(), bukan Provider

  static const _halaman = [
    HalamanProduk(),
    HalamanKeranjang(),
  ];

  @override
  Widget build(BuildContext context) {
    final totalItem = context.select<KeranjangModel, int>(
      (model) => model.totalItem,
    ); // baca totalItem dari Provider

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _indeks == 0 ? 'Menu Kantin' : 'Keranjang ($totalItem)',
        ),
      ),
      body: IndexedStack(
        // setiap halaman tetap hidup di balik layar
        index: _indeks,
        children: _halaman,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _indeks,
        onDestinationSelected: (nilaiBaru) {
          setState(() {
            // hanya _indeks yang diperbarui di sini
            _indeks = nilaiBaru;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.restaurant_menu),
            label: 'Produk',
          ),
          NavigationDestination(
            icon: Icon(Icons.shopping_cart_outlined),
            selectedIcon: Icon(Icons.shopping_cart),
            label: 'Keranjang',
          ),
        ],
      ),
    );
  }
}