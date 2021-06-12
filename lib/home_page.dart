import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:grouped_checkbox/grouped_checkbox.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:connectivity/connectivity.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _citySearchController = TextEditingController();
  final Connectivity _connectivity = Connectivity();
  final String personalWeb = "https://sunitroy2703.github.io";
  final String privacyWeb =
      "https://www.freeprivacypolicy.com/live/aa41fe05-863e-48bc-ad5c-fd1e5525d4fe";
  String data = "data";
  String url;
  String verified = "";
  String unVerified = "";

  List<String> listItem = [
    "Beds",
    "ICU",
    "Oxygen",
    "Ventilator",
    "Food",
    "Tests",
    "Fabiflu",
    "Remdesivir",
    "Favipiravir",
    "Tocilizumab",
    "Plasma",
    "Ambulance"
  ];
  List<String> selectedListItem = [];
  List<String> advanceSearchlistItem = [
    "Show verified tweets only Uncheck this for smaller cities (Tweet should contain 'verified')",
    " Exclude unverified tweets (Tweet should not contain 'not verified' and 'unverified')"
  ];
  List<String> selectedSearchListItem = [];

  var value1 = false;
  var value2 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("helpOut 🙋🏻‍♂️"),
        actions: [
          PopupMenuButton<int>(
            onSelected: (item) => onSelected(context, item),
            itemBuilder: (context) => [
              PopupMenuItem<int>(
                value: 0,
                child: Text("Privacy Policies"),
              ),
              PopupMenuItem<int>(
                value: 1,
                child: Text("Contact Me"),
              ),
            ],
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Text(
                "Twitter Search For Covid",
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  controller: _citySearchController,
                  cursorColor: Colors.blue,
                  decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                      hintText: "Enter city name here",
                      hoverColor: Colors.blue,
                      fillColor: Colors.blue,
                      focusColor: Colors.blue),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Requirements",
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: 24,
                    color: Colors.blue,
                    fontWeight: FontWeight.w300),
              ),
              GroupedCheckbox(
                itemList: listItem,
                checkedItemList: selectedListItem,
                onChanged: (itemList) {
                  setState(() {
                    selectedListItem = itemList as List<String>;
                  });
                },
                orientation: CheckboxOrientation.WRAP,
                checkColor: Colors.white,
                activeColor: Colors.blue,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Search Settings",
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: 24,
                    color: Colors.blue,
                    fontWeight: FontWeight.w300),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: <Widget>[
                  /** Checkbox Widget **/
                  Checkbox(
                    value: value1,
                    onChanged: (bool value) {
                      setState(() {
                        this.value1 = value;
                      });
                    },
                  ),
                  SizedBox(
                    width: 10,
                  ), //SizedBox
                  Container(
                    width: 300,
                    child: Text(
                      "Show verified tweets only Uncheck this for smaller cities (Tweet should contain 'verified')",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 17.0,
                      ),
                      maxLines: 3,
                    ),
                  ), //Text
                  SizedBox(width: 10), //SizedBox
                  //Checkbox
                ], //<Widget>[]
              ),
              SizedBox(height: 10),
              Row(
                children: <Widget>[
                  /** Checkbox Widget **/
                  Checkbox(
                    value: value2,
                    onChanged: (bool value) {
                      setState(() {
                        this.value2 = value;
                      });
                    },
                  ),
                  SizedBox(
                    width: 10,
                  ), //SizedBox
                  Container(
                    constraints: BoxConstraints(minWidth: 250, maxWidth: 300),
                    child: Text(
                      "Exclude unverified tweets (Tweet should not contain 'not verified' and 'unverified",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 17.0,
                      ),
                      maxLines: 3,
                    ),
                  ), //Text
                  SizedBox(width: 10), //SizedBox
                  //Checkbox
                ], //<Widget>[]
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_citySearchController.text.trim().isEmpty) {
            _showToast(context, text: "Please enter a city name!");
            return;
          }
          if ((selectedListItem.isEmpty)) {
            _showToast(context, text: "Please select Requirements!");
            return;
          }
          checkConnection();
        },
        child: Icon(Icons.search),
      ),
    );
  }

  checkConnection() async {
    var _connection = await _connectivity.checkConnectivity();
    if (_connection == ConnectivityResult.none) {
      _showToast(context,
          text:
              "No data connection! Consider turning on mobile data or turning on Wi-Fi");
    } else {
      buidUrl();
    }
  }

  void _showToast(BuildContext context, {String text}) {
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        fontSize: 16.0);
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      if (url == personalWeb) {
        return await launch(
          url,
          forceSafariVC: true,
          enableJavaScript: true,
        );
      }
      return await launch(
        url,
        forceSafariVC: true,
        forceWebView: true,
        enableJavaScript: true,
      );
    } else {
      return throw 'Could not launch $url';
    }
  }

  void buidUrl() {
    String requirement = "";
    for (int i = 0; i < selectedListItem.length; i++) {
      if (i == selectedListItem.length - 1) {
        requirement += selectedListItem[i];
      } else {
        requirement += selectedListItem[i] + '+OR+';
      }
    }

    if (value1 == true) {
      verified = "verified+";
    } else {
      verified = "";
    }

    if (value2 == true) {
      unVerified = "+-%22not+verified%22+-%22unverified%22&";
    } else {
      unVerified = "";
    }

    url = "https://twitter.com/search?q=" +
        verified +
        _citySearchController.text.trim() +
        "+%28" +
        requirement +
        "%29" +
        unVerified +
        "&f=live";

    print(url);
    _launchURL(url);
  }

  onSelected(BuildContext context, int item) {
    switch (item) {
      case 0:
        _launchURL(privacyWeb);
        break;
      case 1:
        _launchURL(personalWeb);
        break;
    }
  }
}
