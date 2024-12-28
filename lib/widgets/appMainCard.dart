import 'package:flutter/material.dart';

import '../util/colors.dart';

class AppMainCardWidget extends StatelessWidget {
  final String cardName;
  final VoidCallback onTap;
  final Icon cardIcon;
  const AppMainCardWidget(
      {Key? key,
      required this.cardName,
      required this.onTap,
      required this.cardIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
          child: Container(
            height: 95,
            child: Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        cardIcon,
                        Text(
                          cardName,
                          style: TextStyle(color: primaryColor, fontSize: 13),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          onTap: onTap),
    );
  }
}
