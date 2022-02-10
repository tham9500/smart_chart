import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_chair/page/home.dart';
import 'package:smart_chair/page/login.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

class LoadApp_page extends StatefulWidget {
  LoadApp_page({Key? key}) : super(key: key);

  @override
  _LoadApp_pageState createState() => _LoadApp_pageState();
}

class _LoadApp_pageState extends State<LoadApp_page> {
  String status = "";

  void initState() {
    // TODO: implement initState
    super.initState();
    Check_state();
  }

  Future<Null> Check_state() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    print(preferences);
    setState(() {
      if (preferences.getString("STATUS") == null) {
        preferences.setString("STATUS", "logout");
        Check_status();
      } else {
        Check_status();
      }
    });
  }

  Future<Null> Check_status() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      status = preferences.getString("STATUS")!;
    });

    if (status == "login") {
      print("login complete");
      User_data();
    } else {
      print("Not login");
    }
  }

  Future<Null> User_data() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      status = preferences.getString("STATUS")!;
      print("status = ${status}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return SplashScreenView(
      navigateRoute: status == "login" ? Home_page() : Login_page(),
      // navigateRoute: Home_page(),
      duration: 3000,
      imageSize: 300,
      imageSrc: "assets/images/logo/logo2.jpg",
      backgroundColor: Color.fromRGBO(255, 255, 255, 1),
    );
  }
}
