import 'package:flutter/material.dart';
import 'package:quotii/model/quote_model.dart';
import 'package:quotii/service/api_service.dart';
import 'package:quotii/widgets/card_widget.dart';

class HomePage extends StatefulWidget {
  final bool isDark;
  final void Function() toggleMode;

  const HomePage({required this.toggleMode, required this.isDark, super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<QuoteModel> quotes = [];
  final api = ApiService();

  @override
  void initState() {
    super.initState();
    loadQuotes();
  }

  void loadQuotes() async {
    final result = await api.fetchQuotes();
    setState(() {
      quotes = result;
      // print(quotes);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffeff3ff),
      appBar: AppBar(
        backgroundColor: Color(0xffeff3ff),
        title: Text(
          'Quotes',
          style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: widget.toggleMode,
            icon: Icon(widget.isDark ? Icons.light_mode : Icons.dark_mode),
          ),
        ],
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          final q = quotes[index];
          return CardWidget(quote: q);
        },
        itemCount: quotes.length,
      ),
    );
  }
}
