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
    final isDark = widget.isDark;

    return Scaffold(
      backgroundColor: isDark
          ? const Color(0xff121212)
          : const Color(0xfff0f0f0),
      appBar: AppBar(
        backgroundColor: isDark
            ? const Color(0xff121212)
            : const Color(0xfff0f0f0),
        elevation: 0,
        title: Text(
          'Quotii',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : Colors.black,
            fontFamily: 'Font',
          ),
        ),
        // Removed toggle button from app bar
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          loadQuotes();
        },
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemBuilder: (context, index) {
            final q = quotes[index];
            return CardWidget(quote: q);
          },
          itemCount: quotes.length,
        ),
      ),
    );
  }
}
