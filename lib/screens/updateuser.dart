import 'package:flutter/material.dart';
import 'package:flutter_application_1/styles.dart';
import 'package:flutter_application_1/widegt/custom_textfield.dart';
import 'package:flutter_application_1/screens/dashboard_screen.dart';
import 'package:flutter_application_1/screens/calcenter.dart';
import 'package:flutter_application_1/screens/smscenter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class updateUser extends StatefulWidget {
  const updateUser({super.key});

  @override
  State<updateUser> createState() => _updateUser();
}

class _updateUser extends State<updateUser> {
  String? user = "";
  String? password = "";
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isObscure = true;

  void getFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      user = prefs.getString("username");
      password = prefs.getString("password");
    });

    if (user == "username" && password == "password") {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => DashboardScreen()));
    }
  }

  Future<bool> performLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      user = prefs.getString("username");
      password = prefs.getString("password");
    });
    if (emailController.text == user && passwordController.text == password) {
      return true;
    }
    return false;
  }

  void handleLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      user = prefs.getString("username");
      password = prefs.getString("password");
    });
    bool isAuthenticated = await performLogin();
    if (isAuthenticated) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DashboardScreen(),
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Login Gagal'),
            content: Text('Username atau password salah.'),
            actions: <Widget>[
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Tutup'),
              ),
            ],
          );
        },
      );
    }
  }

  void setIntoSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("username", emailController.text);
    await prefs.setString("password", passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Update User',
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
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Update Details',
                style: TextStyles.title.copyWith(fontSize: 20.0),
              ),
              const SizedBox(height: 24.0),
              CustomTextfield(
                controller: emailController,
                textInputType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                hint: 'Email or Username',
              ),
              const SizedBox(height: 16.0),
              CustomTextfield(
                controller: passwordController,
                textInputType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.done,
                hint: 'Password',
                isObscure: isObscure,
                hasSuffix: true,
                onPressed: () {
                  setState(() {
                    isObscure = !isObscure;
                  });
                },
              ),
              const SizedBox(height: 24.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.darkBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    )),
                onPressed: () {
                  setIntoSharedPreferences();
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(
                    'Update',
                    style: TextStyles.title.copyWith(
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.darkBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    )),
                onPressed: () {
                  getFromSharedPreferences();
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(
                    'Get',
                    style: TextStyles.title.copyWith(
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24.0),
              Text(
                "Your Username : $user",
                style: TextStyles.body.copyWith(fontSize: 18.0),
                
              ),
              Text(
                "Your Password : $password",
                style: TextStyles.body.copyWith(fontSize: 18.0),
                
              ),
            ],
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

void bukaPeta() async {
  Uri uri = Uri(scheme: "geo", path: "-7.022162,110.506912", query: "q=Es Teh Ajib");
  if (!await launchUrl(uri)) {
    throw Exception("Gagal membuka link!");
  }
}