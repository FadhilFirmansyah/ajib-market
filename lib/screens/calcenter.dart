import 'package:flutter/material.dart';
import 'package:flutter_application_1/styles.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_application_1/screens/dashboard_screen.dart';
import 'package:flutter_application_1/screens/smscenter.dart';
import 'package:flutter_application_1/screens/updateuser.dart';

final Uri _whatsapp = Uri.parse('https://wa.me/+6281328798239/');

class callcenter extends StatelessWidget {
  const callcenter({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Call Center',
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
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Silahkan Hubungi Kami Jika ada kendala Terkait aplikasi Ajib Market',
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 16.0),
              Icon(Icons.chat),
              TextButton(
                onPressed: _WA,
                child: const Text(
                  'WhatsApp',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Icon(Icons.email),
              TextButton(
                onPressed: () {
                  _launchEmail('fadhilpriyatama333@gmail.com',
                      'Subject of the email', 'Body of the email');
                },
                child: Text(
                  'Email : fadhilpriyatama333@gmail.com',
                  style: TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              const SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
    );
  }

  // Fungsi untuk membuka aplikasi email
  _launchEmail(String email, String subject, String body) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: email,
      queryParameters: {
        'subject': subject,
        'body': body,
      },
    );

    if (await canLaunch(emailLaunchUri.toString())) {
      await launch(emailLaunchUri.toString());
    } else {
      throw 'Could not launch $emailLaunchUri';
    }
  }
}

// Fungsi untuk membuka aplikasi WhatsApp
Future<void> _WA() async {
  if (!await launchUrl(_whatsapp)) {
    throw Exception('Could not launch $_whatsapp');
  }
}

final Uri _emailLaunchUri = Uri(
  scheme: 'mailto',
  path: 'fadhilpriyatama333@gmail.com',
  queryParameters: {
    'subject': 'Subject of the email',
    'body': 'Body of the email',
  },
);

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

void bukaPeta() async {
  Uri uri = Uri(scheme: "geo", path: "-7.022162,110.506912", query: "q=Es Teh Ajib");
  if (!await launchUrl(uri)) {
    throw Exception("Gagal membuka link!");
  }
}