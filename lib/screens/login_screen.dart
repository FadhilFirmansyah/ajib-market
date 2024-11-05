import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/dashboard_screen.dart';
import 'package:flutter_application_1/styles.dart';
import 'package:flutter_application_1/widegt/custom_textfield.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:flutter_application_1/screens/register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
          //context, MaterialPageRoute(builder: (context) => const LoginPage()));
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
          'Login',
          style: TextStyles.title.copyWith(
            fontSize: 25.0,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Login Details',
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
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    )),
                onPressed: () {
                  handleLogin();
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(
                    'Login',
                    style: TextStyles.title.copyWith(
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24.0),
              Text(
                'Don\'t have an account ?',
                style: TextStyles.body.copyWith(fontSize: 18.0),
                textAlign: TextAlign.center,
              ),
              TextButton(
                onPressed: () {
                  setIntoSharedPreferences();
                },
                child: Text(
                  'Daftar',
                  style: TextStyles.body.copyWith(
                    fontSize: 18.0,
                    color: AppColors.darkBlue,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
