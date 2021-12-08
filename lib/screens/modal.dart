import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ModalSheeet {
  void aboutModal(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext builder) {
          FocusScope.of(context).unfocus();
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.4,
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      CircleAvatar(
                        radius: 25,
                        backgroundImage: AssetImage('assets/profile.jpg'),
                      ),
                      Text(
                        'Samson Moses',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      ElevatedButton.icon(
                          onPressed: () {
                            launch('mailto:knomic10@gmail.com');
                          },
                          style: ElevatedButton.styleFrom(
                            shadowColor: Colors.grey,
                            elevation: 5,
                            primary: Colors.black,
                            onPrimary: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          icon: Icon(
                            Icons.mail,
                            color: Colors.white,
                          ),
                          label: Text(
                            'Contact',
                            style: TextStyle(color: Colors.white),
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(children: <Widget>[
                      Expanded(
                          child: Divider(
                        thickness: 2,
                      )),
                      Text(
                        "Socials",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Expanded(
                          child: Divider(
                        thickness: 2,
                      )),
                    ]),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      ElevatedButton.icon(
                          icon: Icon(
                            FontAwesomeIcons.github,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            launch('https://github.com/papi-knomic');
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          label: Text(
                            'GitHub',
                            style: TextStyle(color: Colors.black),
                          )),
                      ElevatedButton.icon(
                          icon: Icon(
                            Entypo.linkedin_circled,
                            color: Colors.blue[900],
                          ),
                          onPressed: () {
                            launch('https://www.linkedin.com/in/mknomic/');
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          label: Text(
                            'LinkedIn',
                            style: TextStyle(color: Colors.black),
                          )),
                      ElevatedButton.icon(
                          icon: Icon(
                            Entypo.twitter_circled,
                            color: Colors.blue[400],
                          ),
                          onPressed: () {
                            launch('https://twitter.com/PapiKnomic');
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          label: Text(
                            'Twitter',
                            style: TextStyle(color: Colors.black),
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'This app provides live rates for 500 crypto currencies ranked by CoinGecko in descending order. The data used in this app is provided for free via the CoinGecko API',
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 10),
                  Center(
                    child: ElevatedButton.icon(
                      icon: Icon(
                        Icons.link,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        launch('https://www.coingecko.com/en/api');
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      label: Text('Coin Gecko'),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: "Made with ",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                        WidgetSpan(
                          child: Icon(
                            FontAwesomeIcons.solidHeart,
                            size: 14,
                            color: Colors.red,
                          ),
                        ),
                        TextSpan(
                            text: " from Lagos, NG",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
