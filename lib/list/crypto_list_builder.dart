import 'package:crypto_xe/services/currency.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart' as intl;

class CryptoListBuilder extends StatelessWidget {
  final List<Currency> cryptos;
  final String search;
  List<Currency> _searchlist = [];
  final VoidCallback onRefresh;

  CryptoListBuilder(this.cryptos, this.search, this.onRefresh) {
    _searchlist = createSearch(search, cryptos);
  }

  @override
  Widget build(BuildContext context) {
    return search != null && _searchlist.isEmpty
        ? Center(
            child: Text('CrytoCurrency Not Found'),
          )
        : RefreshIndicator(
            onRefresh: onRefresh,
            color: Colors.black,
            child: Scrollbar(
              child: ListView.separated(
                physics: AlwaysScrollableScrollPhysics(),
                separatorBuilder: (context, index) {
                  return Divider();
                },
                shrinkWrap: true,
                itemCount:
                    _searchlist.isEmpty ? cryptos.length : _searchlist.length,
                itemBuilder: (context, index) {
                  return _searchlist.isEmpty
                      ? listTiles(
                          cryptos[index].name,
                          getDecimalPlaces(cryptos[index].price),
                          cryptos[index].imageUrl,
                          cryptos[index].symbol,
                          cryptos[index].percentChange24h,
                          cryptos[index].percentChange7d,
                          getDecimalPlaces(cryptos[index].ath),
                        )
                      : listTiles(
                          _searchlist[index].name,
                          getDecimalPlaces(_searchlist[index].price),
                          _searchlist[index].imageUrl,
                          _searchlist[index].symbol,
                          _searchlist[index].percentChange24h,
                          _searchlist[index].percentChange7d,
                          getDecimalPlaces(_searchlist[index].ath),
                        );
                },
              ),
            ),
          );
  }
}

Widget listTiles(name, price, imageUrl, symbol, change24, change7, ath) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 5.0),
    child: ListTile(
      leading: CircleAvatar(
        radius: 20,
        backgroundColor: Colors.white,
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          progressIndicatorBuilder: (context, imageUrl, downloadProgress) =>
              CircularProgressIndicator(
                  value: downloadProgress.progress,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.black)),
          errorWidget: (context, url, error) => Icon(
            Icons.error,
            color: Colors.red,
          ),
        ),
      ),
      title: Text(
        name,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: RichText(
          text: TextSpan(children: [
        TextSpan(
          text: 'Price: $price\n',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        TextSpan(
          text: "Symbol: $symbol\n",
          style: TextStyle(color: Colors.black),
        ),
        TextSpan(
            text:
                "Change(24h): ${change24 != null ? intl.NumberFormat.decimalPattern().format(change24).toString() + "%" : "null"}\n",
            style: TextStyle(
                color: change24 != null && change24 != 0
                    ? (change24.isNegative ? Colors.red : Colors.green)
                    : Colors.black)),
        TextSpan(
            text:
                "Change(7d): ${change7 != null ? intl.NumberFormat.decimalPattern().format(change7).toString() + "%" : "null"}\n",
            style: TextStyle(
                color: change7 != null && change7 != 0
                    ? (change7.isNegative ? Colors.red : Colors.green)
                    : Colors.black)),
        TextSpan(
          text: "ATH: $ath",
          style: TextStyle(color: Colors.black),
        )
      ])),
      // trailing: Icon(FontAwesomeIcons.heart),
    ),
  );
}

List<void> createSearch(String search, List currencies) {
  List<Currency> searchList = [];
  if (search != null && currencies.isNotEmpty) {
    currencies.forEach((currency) {
      if (currency.name
              .toString()
              .toLowerCase()
              .contains(search.toLowerCase()) ||
          currency.symbol
              .toString()
              .toLowerCase()
              .contains(search.toLowerCase())) {
        searchList.add(Currency(
            name: currency.name,
            price: currency.price,
            imageUrl: currency.imageUrl,
            symbol: currency.symbol,
            percentChange24h: currency.percentChange24h,
            percentChange7d: currency.percentChange7d,
            ath: currency.ath));
      }
    });
  }
  return searchList;
}

// checks how many decimal places a double has and returns the number of digits
String getDecimalPlaces(num number) {
  bool check = number.toString().contains('.');
  var decimals = check ? number.toString().split('.')[1].length : 0;
  return intl.NumberFormat.simpleCurrency(decimalDigits: decimals)
      .format(number)
      .toString();
}
