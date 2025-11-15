import 'package:flutter/material.dart';
import 'package:quotii/model/quote_model.dart';

class CardWidget extends StatelessWidget {
  final QuoteModel quote;

  const CardWidget({required this.quote, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xffffffff),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      margin: EdgeInsets.all(25),
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Text(textAlign: TextAlign.center, quote.quote, style: TextStyle()),
            SizedBox(height: 20),
            Text(quote.author, style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.favorite_border_outlined,
                  color: Colors.red,
                  size: 30,
                ),
                SizedBox(width: 50),
                Icon(Icons.share_rounded, color: Colors.blue, size: 30),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
