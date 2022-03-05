import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_chair/page/login.dart';
import 'package:smart_chair/page/qrview.dart';

class Home_page extends StatefulWidget {
  Home_page({Key? key}) : super(key: key);

  @override
  State<Home_page> createState() => _Home_pageState();
}

class _Home_pageState extends State<Home_page> {
  String displayId = "";
  String displayName = "";
  String displayRole = "";
  void initState() {
    // TODO: implement initState
    super.initState();
    User_data();
  }

  Future<Null> User_data() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      displayId = preferences.getString("ID")!;
      displayName = preferences.getString("USERNAME")!;
      displayRole = preferences.getString("ROLE")!;
    });
    print("login complete");
  }

  Future<Null> routeServiceLogout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
    preferences.setString('STATUS', "logout");
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Login_page(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromRGBO(160, 106, 106, 1),
        title: const Text('หน้าแรก'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.notifications),
            tooltip: 'Show Snackbar',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('This is a snackbar')));
            },
          ),
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            tooltip: 'Go to the next page',
            onPressed: () {
              print("logput");
              routeServiceLogout();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              children: <Widget>[
                Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Row(
                          children: <Widget>[
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "ยินดีต้อนรับคุณ ",
                                style: TextStyle(
                                    fontSize: 24,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "${displayName},${displayId}",
                                style: TextStyle(
                                    fontSize: 24,
                                    color: Colors.blueAccent.shade700,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15),
                Scroll_menu()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget Scroll_menu() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            child: Column(
              children: <Widget>[
                //widget open page game
                Scan(),
                SizedBox(height: 15),
                ChairStatus(),
                SizedBox(height: 15),
                Container(
                  child: displayRole == "admin" ? Stat_chart() : null,
                ),

                //widget open page catergory
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget Scan() {
    return Container(
      height: 120,
      width: MediaQuery.of(context).size.width * 0.82,

      // color: Colors.amber.shade200,
      child: ElevatedButton(
        style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
            backgroundColor: MaterialStateProperty.all<Color>(
                Color.fromRGBO(255, 88, 59, 1)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              child: Row(
                children: <Widget>[
                  Container(
                    child: Icon(Icons.qr_code, size: 70, color: Colors.white),
                  ),
                  SizedBox(width: 30),
                  Container(
                    child: Text(
                      "สแกน QR Code",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        onPressed: () {
          print("games colors click");
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => QRViewExample()));
        },
      ),
    );
  }

  Widget ChairStatus() {
    return Container(
      height: 120,
      width: MediaQuery.of(context).size.width * 0.82,

      // color: Colors.amber.shade200,
      child: ElevatedButton(
        style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
            backgroundColor:
                MaterialStateProperty.all<Color>(Color.fromRGBO(26, 0, 128, 1)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              child: Row(
                children: <Widget>[
                  Container(
                    child: Icon(Icons.chair, size: 70, color: Colors.white),
                  ),
                  SizedBox(width: 30),
                  Container(
                    child: Text(
                      "สถานะการนั้ง",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        onPressed: () {
          print("games colors click");
          // Navigator.push(context,
          //     MaterialPageRoute(builder: (context) => Home_game()));
        },
      ),
    );
  }

  Widget Stat_chart() {
    return Container(
      height: 120,
      width: MediaQuery.of(context).size.width * 0.82,

      // color: Colors.amber.shade200,
      child: ElevatedButton(
        style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
            backgroundColor:
                MaterialStateProperty.all<Color>(Color.fromRGBO(63, 63, 63, 1)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              child: Row(
                children: <Widget>[
                  Container(
                    child: Icon(Icons.auto_graph_outlined,
                        size: 70, color: Colors.white),
                  ),
                  SizedBox(width: 30),
                  Container(
                    child: Text(
                      "สถิติการนั่งย้อนหลัง",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        onPressed: () {
          print("games colors click");
          // Navigator.push(context,
          //     MaterialPageRoute(builder: (context) => Home_game()));
        },
      ),
    );
  }
}
