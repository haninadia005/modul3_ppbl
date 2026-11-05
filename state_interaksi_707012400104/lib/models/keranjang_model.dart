// lib/models/keranjang_model.dart
import 'package:flutter/foundation.dart';

@immutable
class Produk {
  const Produk({
    required this.nama,
    required this.harga,
    required this.ikon,
  });

  final String nama;
  final int harga;
  final String ikon;
}

class ItemKeranjang {
  ItemKeranjang({required this.produk, this.jumlah = 1});

  final Produk produk;
  int jumlah;
}

class KeranjangModel extends ChangeNotifier {
  // Variabel map utamanya menggunakan _items
  final Map<String, ItemKeranjang> _items = {};

  // Perbaikan: gunakan _items.values karena _items adalah Map
  List<ItemKeranjang> get items => List.unmodifiable(_items.values);

  int get totalItem {
    // Perbaikan: gunakan _items.values
    return _items.values.fold(0, (total, item) => total + item.jumlah);
  }

  int get totalHarga {
    // Perbaikan: gunakan _items.values
    return _items.values.fold(
      0,
      (total, item) => total + (item.produk.harga * item.jumlah),
    );
  }

  void tambah(Produk produk) {
    // Perbaikan: akses _items, bukan items
    final itemLama = _items[produk.nama];

    if (itemLama == null) {
      _items[produk.nama] = ItemKeranjang(produk: produk);
    } else {
      itemLama.jumlah++;
    }

    notifyListeners();
  }

  void kurangi(Produk produk) {
    final itemLama = _items[produk.nama];
    if (itemLama == null) return;

    if (itemLama.jumlah == 1) {
      _items.remove(produk.nama); // Perbaikan: gunakan _items.remove
    } else {
      itemLama.jumlah--;
    }

    notifyListeners();
  }

  void kosongkan() {
    if (_items.isEmpty) return;
    _items.clear(); // Perbaikan: gunakan _items.clear
    notifyListeners();
  }
}