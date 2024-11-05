import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/dashboard_screen.dart';
import 'package:flutter_application_1/styles.dart';

class HistoriBelanja extends StatefulWidget {
  final String productName;
  final String description;
  final String imagePath;
  final String price;
  final int quantity;
  final double totalPrice;
  final String selectedShippingMethod;

  const HistoriBelanja({super.key, 
    required this.productName,
    required this.description,
    required this.imagePath,
    required this.price,
    required this.quantity,
    required this.totalPrice,
    required this.selectedShippingMethod,
  });

  @override
  _HistoriBelanjaState createState() => _HistoriBelanjaState();
}

class _HistoriBelanjaState extends State<HistoriBelanja> {
  int quantity = 0;
  String selectedShippingMethod = 'Reguler'; // Default jenis paket
  List<String> shippingMethods = ['Reguler', 'Express', 'Super Express'];

  // Fungsi untuk mengonversi string harga menjadi double
  double parsePrice(String price) {
    // Hapus karakter non-numerik dari string harga
    String cleanedPrice = price.replaceAll(RegExp(r'[^0-9]'), '');

    // Ubah string yang telah dibersihkan menjadi double
    return double.parse(cleanedPrice);
  }

  double getTotalPriceWithShipping() {
    double shippingCost = 0.0;

    switch (widget.selectedShippingMethod) {
      case 'Reguler':
        shippingCost = 5000;
        break;
      case 'Express':
        shippingCost = 10000;
        break;
      case 'Super Express':
        shippingCost = 20000;
        break;
    }

    return widget.totalPrice + shippingCost;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'History',
          style: TextStyles.title.copyWith(
            fontSize: 25.0,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.darkBlue,
        elevation: 0,
      ),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(widget.imagePath),
                    )),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Rincian Pembelian',
                      style: TextStyles.title.copyWith(fontSize: 18.0),
                    ),
                    Text(
                      'Nama Produk: ${widget.productName}',
                      style: TextStyles.body.copyWith(fontSize: 15.0),
                    ),
                    Text(
                      'Jumlah: ${widget.quantity}',
                      style: TextStyles.body.copyWith(fontSize: 15.0),
                    ),
                    Text(
                      'Total Harga dengan Ongkir: Rp. ${getTotalPriceWithShipping().toStringAsFixed(2)}',
                      style: TextStyles.body.copyWith(fontSize: 15.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 12),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.darkBlue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          )),
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DashboardScreen()));
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: Text(
                          'Kembali',
                          style: TextStyles.title.copyWith(
                            fontSize: 18.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
