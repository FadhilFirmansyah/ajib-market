import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/histori_belanja.dart';
import 'package:flutter_application_1/styles.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PaymentScreen extends StatefulWidget {
  final String productName;
  final String description;
  final String imagePath;
  final String price;
  final int quantity;
  final double totalPrice;

  const PaymentScreen({super.key, 
    required this.productName,
    required this.description,
    required this.imagePath,
    required this.price,
    required this.quantity,
    required this.totalPrice,
  });

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String selectedShippingMethod = 'Reguler'; // Default jenis paket
  String destination = ''; // Variable untuk menyimpan tujuan lokasi pengiriman
  List<String> shippingMethods = ['Reguler', 'Express', 'Super Express'];

  bool isMobileBankingPaymentCompleted =
      false; // Status pembayaran untuk metode transfer mobile banking

  // Controller untuk input nomor rekening dan jumlah transfer
  TextEditingController accountNumberController = TextEditingController();
  TextEditingController transferAmountController = TextEditingController();

  void completePayment(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Pembayaran Selesai'),
          content: Text(
              'Terima kasih telah menyelesaikan pembayaran untuk ${widget.productName} sebanyak ${widget.quantity} buah. Total Harga: Rp. ${widget.totalPrice}'),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog
                Navigator.of(context).pop(); // Kembali ke halaman dashboard
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  double getTotalPriceWithShipping() {
    double shippingCost = 0.0;

    switch (selectedShippingMethod) {
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

  void printInvoice() async {
    final doc = pw.Document();

    // Tambahkan konten nota ke dokumen
    doc.addPage(pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (Context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              '--- Nota Pembayaran ---',
              style: pw.TextStyle(fontSize: 20.0),
            ),
            pw.SizedBox(height: 10),
            pw.Text(
              'Nama Produk: ${widget.productName}',
              style: pw.TextStyle(fontSize: 16.0),
            ),
            pw.Text(
              'Jumlah: ${widget.quantity}',
              style: pw.TextStyle(fontSize: 16.0),
            ),
            pw.Text(
              'Total Harga: Rp. ${widget.totalPrice}',
              style: pw.TextStyle(fontSize: 16.0),
            ),
            pw.Text(
              'Jenis Paket Pengiriman: $selectedShippingMethod',
              style: pw.TextStyle(fontSize: 16.0),
            ),
            pw.Text(
              'Tujuan Pengiriman: $destination',
              style: pw.TextStyle(fontSize: 16.0),
            ),
            pw.Text(
              'Total Harga dengan Ongkos Kirim: Rp. ${getTotalPriceWithShipping().toStringAsFixed(2)}',
              style: pw.TextStyle(fontSize: 16.0),
            ),
            pw.SizedBox(height: 10),
            pw.SizedBox(
              child: pw.FittedBox(
                child: pw.Text('Terima kasih atas pembayaran Anda!',
                    style: pw.TextStyle(fontSize: 20.0)),
              ),
            ),
          ],
        );
      },
    ));

    // Gunakan package printing untuk mencetak dokumen
    Printing.layoutPdf(onLayout: (format) async => doc.save());
  }

  void completeMobileBankingPayment() {
    if (accountNumberController.text.isEmpty ||
        transferAmountController.text.isEmpty) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Gagal'),
            content: Text('Harap isi nomor rekening dan jumlah transfer.'),
            actions: <Widget>[
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
      return;
    }

    // Implementasi logika pembayaran untuk metode transfer mobile banking
    // Anda dapat menyimpan data pembayaran, mengirim ke server, dll.

    // Set status pembayaran transfer mobile banking menjadi true
    setState(() {
      isMobileBankingPaymentCompleted = true;
    });

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Pembayaran Selesai'),
          content: isMobileBankingPaymentCompleted
              ? Text(
                  'Pembayaran melalui transfer mobile banking selesai untuk ${widget.productName} sebanyak ${widget.quantity} buah. Total Harga: Rp. ${widget.totalPrice}')
              : Text('Pembayaran belum selesai'),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog
                if (isMobileBankingPaymentCompleted) {
                  Navigator.of(context).pop(); // Kembali ke halaman dashboard
                }
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Widget buildMobileBankingForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: accountNumberController,
          decoration: InputDecoration(labelText: 'Nomor Rekening Tujuan'),
        ),
        TextField(
          controller: transferAmountController,
          decoration: InputDecoration(labelText: 'Jumlah Transfer'),
          keyboardType: TextInputType.number,
        ),
      ],
    );
  }

  Widget buildPaymentMethods() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text('Transfer Mobile Banking'),
                  content: buildMobileBankingForm(),
                  actions: <Widget>[
                    ElevatedButton(
                      onPressed: () {
                        completeMobileBankingPayment();
                        Navigator.of(context).pop(); // Tutup dialog
                      },
                      child: Text('Bayar'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pop(); // Tutup dialog tanpa pembayaran
                      },
                      child: Text('Batal'),
                    ),
                  ],
                );
              },
            );
          },
          child: Text('Transfer Mobile Banking'),
        ),
        ElevatedButton(
          onPressed: () {
            // Implementasi logika untuk metode pembayaran lainnya (jika ada)
          },
          child: Text('Metode Pembayaran Lainnya'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Form Pembayaran',
          style: TextStyles.title.copyWith(
            fontSize: 25.0,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.darkBlue,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Rincian Pembelian:',
                style: TextStyles.title.copyWith(fontSize: 20.0),
              ),
              SizedBox(height: 8),
              Text('Nama Produk: ${widget.productName}',
                  style: TextStyle(fontSize: 16)),
              Text('Jumlah: ${widget.quantity}',
                  style: TextStyle(fontSize: 16)),
              Text('Total Harga: Rp. ${widget.totalPrice}',
                  style: TextStyle(fontSize: 16)),
              const SizedBox(height: 24.0),
              Text(
                'Rincian Pengiriman:',
                style: TextStyles.title.copyWith(fontSize: 20.0),
              ),
              const SizedBox(height: 8),
              DropdownButton<String>(
                value: selectedShippingMethod,
                onChanged: (String? value) {
                  setState(() {
                    selectedShippingMethod = value!;
                  });
                },
                items: shippingMethods
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                hint: Text('Pilih Jenis Paket'),
              ),
              const SizedBox(height: 16.0),
              TextField(
                style: TextStyles.body,
                textInputAction: TextInputAction.next,
                onChanged: (value) {
                  setState(() {
                    destination = value;
                  });
                },
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      width: 1.0,
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      width: 1.0,
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  hintText: 'Tujuan Pengiriman',
                  hintStyle: TextStyles.body,
                ),
              ),
              const SizedBox(height: 16.0),
              Text(
                'Total Harga dengan Ongkir: Rp. ${getTotalPriceWithShipping().toStringAsFixed(2)}',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 24.0),
              buildPaymentMethods(),
              const SizedBox(height: 24.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.darkBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HistoriBelanja(
                        productName: widget.productName,
                        description: widget.description,
                        imagePath: widget.imagePath,
                        price: widget.price,
                        quantity: widget.quantity,
                        totalPrice: widget.totalPrice, 
                        selectedShippingMethod: selectedShippingMethod,
                      ),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(
                    'Selesaikan Pembayaran',
                    style: TextStyles.title.copyWith(
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24.0),
              TextButton(
                onPressed: () {
                  printInvoice();
                },
                child: Text(
                  'Cetak Nota Pembayaran',
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
