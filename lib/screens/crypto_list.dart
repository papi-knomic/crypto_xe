// import 'package:crypto_xe/services/currency.dart';
import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:crypto_xe/list/crypto_list_builder.dart';
import 'package:crypto_xe/screens/modal.dart';
import 'package:crypto_xe/services/currency.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class CryptoList extends StatefulWidget {
  get refresh => null;

  @override
  _CryptoListState createState() => _CryptoListState();
}

class _CryptoListState extends State<CryptoList> {
  TextEditingController controller = new TextEditingController();
  Future<List<Currency>> _listFuture;
  String search;
  bool _refresh = true;
  bool err = false;
  int selectedIndex = 0;
  int _hours = 0;
  ModalSheeet _modalSheeet = new ModalSheeet();

  Future<bool> hasNetwork() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return false;
    } else {
      // I am connected to a wifi network.
      return true;
    }
  }

  Future<List<Currency>> getCrypto() async {
    var rates;

    if (await hasNetwork()) {
      try {
        var response = await http.get(
          Uri.parse(
              "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=gecko_desc&per_page=250&sparkline=false&price_change_percentage=1h%2C24h%2C7d"),
        );

        if (response.statusCode == 200) {
          rates = Currency.decode(response.body);
          var response2 = await http.get(
            Uri.parse(
                "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=gecko_desc&per_page=250&page=2&sparkline=false&price_change_percentage=1h%2C24h%2C7d"),
          );
          if (response2.statusCode == 200) {
            rates.addAll(Currency.decode(response2.body));
          }
          await _saveList(rates);
          setState(() {
            _refresh = true;
          });
        } else {
          rates = await _getList();
          setState(() {
            _refresh = false;
          });
        }
      } catch (e) {
        print(e);
        rates = await _getList();
        setState(() {
          _refresh = false;
        });
      }
    } else {
      var rates = await _getList();

      setState(() {
        rates = rates;
        _refresh = false;
      });
      return rates;
    }

    return rates;
  }

  void initState() {
    super.initState();
    _listFuture = getCrypto();
  }

  snackbar(Text text) {
    var snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      elevation: 5,
      content: text,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
    );
    return ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> refreshList() async {
    Text text = Text('Refreshing',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ));

    snackbar(text);
    await getCrypto().then((value) async {
      if (_refresh) {
        setState(() {
          text = Text(
            'Refreshed',
            style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
          );
          _listFuture = getCrypto();
        });
        snackbar(text);
      } else {
        setState(() {
          text = Text(
            'Refresh Failed',
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
          );

          _listFuture = _getList();
        });
        snackbar(text);
      }
    });
  }

  Future<void> _saveList(var currency) async {
    final prefs = await SharedPreferences.getInstance();
    final String encodedData = Currency.encode(currency);
    await prefs.setString('currency', encodedData);
  }

  Future<List<Currency>> _getList() async {
    final prefs = await SharedPreferences.getInstance();
    final String currencyString = await prefs.getString('currency');
    var crypto;

    if (currencyString != null) {
      crypto = Currency.decode(currencyString);
      setState(() {
        err = false;
      });
    } else {
      setState(() {
        err = true;
      });
    }

    return crypto;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _listFuture,
        builder: (context, snapshot) {
          return SafeArea(
            child: Scaffold(
                appBar: AppBar(
                    backgroundColor: Colors.black,
                    title: Text(
                      'Crypto XR',
                    ),
                    centerTitle: false,
                    elevation: 0,
                    actions: <Widget>[
                      IconButton(
                          icon: Icon(Icons.info_outline),
                          onPressed: () {
                            _modalSheeet.aboutModal(context);
                          }),
                    ],
                    bottom: PreferredSize(
                      preferredSize: Size.fromHeight(50),
                      child: TextField(
                          controller: controller,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: 'Search Coins by name or symbol...',
                            contentPadding: EdgeInsets.all(20.0),
                            hintStyle: TextStyle(
                                color: Colors.grey[400], fontSize: 16),
                            prefixIcon: Icon(
                              Icons.search,
                              color: Colors.white,
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                Icons.clear,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                controller.clear();
                                FocusScope.of(context).unfocus();
                                setState(() {
                                  search = '';
                                });
                              },
                            ),
                          ),
                          onChanged: (value) {
                            setState(() {
                              search = value;
                            });
                          }),
                    )),
                body: snapshot.hasError || err
                    ? Center(
                        child: Text(
                          'Could Not Get List, Please Try Again Later!',
                        ),
                      )
                    : (snapshot.hasData
                        ? CryptoListBuilder(snapshot.data, search, refreshList)
                        : Center(
                            child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.black)),
                          ))),
          );
        });
  }
}
