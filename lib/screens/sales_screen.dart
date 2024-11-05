import 'package:flutter/material.dart';
import 'package:flutter_application_1/styles.dart';
import 'package:flutter_application_1/screens/payment_screen.dart';


class SalesScreen extends StatefulWidget {
  final String productName;
  final String description;
  final String imagePath;
  final String price;

  const SalesScreen({super.key, 
    required this.productName,
    required this.description,
    required this.imagePath,
    required this.price,
  });

  @override
  _SalesScreenState createState() => _SalesScreenState();
}

class _SalesScreenState extends State<SalesScreen> {
  int quantity = 0;

  // Fungsi untuk mengonversi string harga menjadi double
  double parsePrice(String price) {
    // Hapus karakter non-numerik dari string harga
    String cleanedPrice = price.replaceAll(RegExp(r'[^0-9]'), '');

    // Ubah string yang telah dibersihkan menjadi double
    return double.parse(cleanedPrice);
  }

  @override
  Widget build(BuildContext context) {
    double totalPrice = parsePrice(widget.price) * quantity;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pembelian',
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
                      widget.productName,
                      style: TextStyles.title.copyWith(fontSize: 20.0),
                    ),
                    SizedBox(height: 8),
                    Text(
                      widget.description,
                      textAlign: TextAlign.left,
                      style: TextStyles.body.copyWith(fontSize: 15.0),
                    ),
                    SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      
                      children: [
                        Text(
                          'Rp. ${totalPrice.toStringAsFixed(2)}',
                          style: TextStyles.body.copyWith(
                              fontSize: 15.0, fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  if (quantity > 0) {
                                    quantity--;
                                  }
                                });
                              },
                              icon: Icon(Icons.remove_circle,
                                  color: AppColors.darkBlue),
                            ),
                            SizedBox(width: 10),
                            Text(
                              '$quantity',
                              textAlign: TextAlign.left,
                              style: TextStyles.body.copyWith(fontSize: 15.0),
                            ),
                            SizedBox(width: 10),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  quantity++;
                                });
                              },
                              icon: Icon(Icons.add_circle,
                                  color: AppColors.darkBlue),
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 12),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.darkBlue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          )),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PaymentScreen(
                              productName: widget.productName,
                              description: widget.description,
                              imagePath: widget.imagePath,
                              price: widget.price,
                              quantity: quantity,
                              totalPrice: totalPrice, 
                              
                            ),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: Text(
                          'Checkout',
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
