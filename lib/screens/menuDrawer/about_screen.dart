import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vistaar_bandhu_new_version/multilanguage.dart';
import 'package:vistaar_bandhu_new_version/screens/menuDrawer/drawer_screen.dart';
import 'package:vistaar_bandhu_new_version/util/colors.dart';

class AboutScreen extends StatefulWidget {
  static const routeName = '/AboutScreen';

  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        title: Text(
          MultiLanguage.of(context)!
              .translate("about_vistaar"), //"About Vistaar",
          style: const TextStyle(color: goldColor),
        ),
        centerTitle: true,
      ),
      drawer: AppDrawer(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Image.asset(
                'assets/images/vist_img_7.png',
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: Text(
                  // '''Vistaar is a commitment by two entrepreneurs and over 2000 employees who believe that by supporting and creating new economic opportunities for deserving small business women and men, lives can be enriched and communities can be transformed. The company focuses on the missing middle segment, which is not effectively served by the formal financial system.''',
                  MultiLanguage.of(context)!.translate("about_us_first"),
                  style: const TextStyle(
                      fontSize: 17,
                      color: Colors.black,
                      fontWeight: FontWeight.w700),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: Text(
                  //'''The objective is to make finance available at a reasonable cost and deliver in a transparent manner. In the process, Vistaar aims to continuously attract mainstream capital and human resources to serve these chosen segments who are the backbone of India’s vibrant economy.''',
                  MultiLanguage.of(context)!.translate("about_us_second"),

                  style: const TextStyle(
                      fontSize: 17,
                      color: Colors.black,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
