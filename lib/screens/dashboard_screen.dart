import 'package:flutter/material.dart';
import 'package:flutter_application_1/styles.dart';
import 'package:flutter_application_1/screens/calcenter.dart';
import 'package:flutter_application_1/screens/product_detail_screen.dart';
import 'package:flutter_application_1/screens/smscenter.dart';
import 'package:flutter_application_1/screens/updateuser.dart';
import 'package:url_launcher/url_launcher.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Dasdboard',
          style: TextStyles.title.copyWith(
            fontSize: 25.0,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.darkBlue,
        elevation: 0,
      ),
      endDrawer: MyDrawer(),
      body: SingleChildScrollView(
        child: ProductRow(
          product1: ProductItem(
            name: 'Teh Segar',
            description: 'Teh segar bisa es bisa panas, kenyamanan tanggung pembeli masing-masing, jangan lupa beli yaaaa',
            price: 'Rp 3.000',
            productName: 'Teh Segar',
            imagePath: 'assets/Teh-Ajib1.png', // Path gambar produk
            ingredientsProduct: 'Daun teh',
          ),
          product2: ProductItem(
            name: 'Teh Segar v2',
            description: 'Teh segar bisa es bisa panas, kenyamanan tanggung pembeli masing-masing, jangan lupa beli yaaaa',
            price: 'Rp 5.000',
            productName: 'Teh Segar v2',
            imagePath: 'assets/Teh-Ajib2.jpg', // Path gambar produk
            ingredientsProduct: 'Daun teh',
          ),
          product3: ProductItem(
            name: 'Gorengan Mini',
            description: 'Gorengan dari bahan olah tahu yang bisa layak dimakan hangat-hangat',
            price: 'Rp 10.000',
            productName: 'Gorengan Mini',
            imagePath: 'assets/Gorengan-Ajib1.jpg', // Path gambar produk
            ingredientsProduct: 'Tahu',
          ),
          product4: ProductItem(
            name: 'Gorengan Jumbo',
            description: 'Gorengan dari bahan olah tahu, tempe, dll yang bisa layak dimakan hangat-hangat',
            price: 'Rp 25.000',
            productName: 'Gorengan Jumbo',
            imagePath: 'assets/Gorengan-Ajib2.jpg', // Path gambar produk
            ingredientsProduct: 'Tempura',
          ),
          product5: ProductItem(
            name: 'Lumpia Enak',
            description: 'Jajanan lumpia makanan khas Semarang yang nikmat disantap bersama lohhhh',
            price: 'Rp 15.000',
            productName: 'Lumpia Enak',
            imagePath: 'assets/Lumpia-Ajib1.jpg', // Path gambar produk
            ingredientsProduct:'Rebung',
          ),
          product6: ProductItem(
            name: 'Lumpia Enak',
            description: 'Jajanan lumpia makanan khas Semarang yang nikmat disantap bersama lohhhh',
            price: 'Rp 20.000',
            productName: 'Lumpia Enak',
            imagePath: 'assets/Lumpia-Ajib2.jpg', // Path gambar produk
            ingredientsProduct:'Rebung',
          ),
        ),
      ),
    );
  }
}

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: AppColors.darkBlue,
            ),
            child: Text(
              'Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Dashboard'),
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => DashboardScreen()));
              
            },
          ),
          ListTile(
            leading: Icon(Icons.call),
            title: Text('Call Center'),
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => callcenter()));
              
            },
          ),
          ListTile(
            leading: Icon(Icons.sms),
            title: Text('SMS Center'),
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => smscenter()));
              
            },
          ),
          ListTile(
            leading: Icon(Icons.map),
            title: Text('Lokasi'),
            onTap: () {
              bukaPeta();
            },
          ),
          ListTile(
            leading: Icon(Icons.people),
            title: Text('Update User'),
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => updateUser()));
            },
          ),
          // Tambahkan item menu lainnya di sini
        ],
      ),
    );
  }
}

class ProductRow extends StatelessWidget {
  final ProductItem product1;
  final ProductItem product2;
  final ProductItem product3;
  final ProductItem product4;
  final ProductItem product5;
  final ProductItem product6;

  const ProductRow({super.key, 
    required this.product1,
    required this.product2,
    required this.product3,
    required this.product4,
    required this.product5,
    required this.product6,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [product1, product2],
        ),
        Row(
          children: [product3, product4],
        ),
        Row(
          children: [product5, product6],
        ),
      ],
    );
  }
}

class ProductItem extends StatelessWidget {
  final String name;
  final String description;
  final String price;
  final String productName;
  final String imagePath;
  final String ingredientsProduct;

  const ProductItem({super.key, 
    required this.name,
    required this.description,
    required this.price,
    required this.productName,
    required this.imagePath,
    required this.ingredientsProduct,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    ProductDetailScreen(productName: productName, description: description, imagePath: imagePath, ingredientsProduct: ingredientsProduct, price: price,),
              ),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(imagePath,width: 100,height: 100,), // Menampilkan gambar produk
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(description),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(price),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void bukaPeta() async {
  Uri uri = Uri(scheme: "geo", path: "-7.022162,110.506912", query: "q=Es Teh Ajib");
  if (!await launchUrl(uri)) {
    throw Exception("Gagal membuka link!");
  }
}