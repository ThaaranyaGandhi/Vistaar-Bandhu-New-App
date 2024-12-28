import 'package:flutter/material.dart';

class EmptyMessage extends StatelessWidget {
 final String message;

  EmptyMessage(this.message);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
//                  SizedBox(
//                    height: 70,
//                    child: Image.asset('assets/images/Not-Available_300x300.png'),
//                  ),
            Text(
              '🙌',
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10,),
            Text(
              message,
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
          ]),
    );
  }
}
