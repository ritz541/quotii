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
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

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
        actions: [
          Container(
            margin: const EdgeInsets.all(6),
            child: ElevatedButton(
              onPressed: widget.toggleMode,
              style: ElevatedButton.styleFrom(
                backgroundColor: isDark
                    ? const Color(0xff333333)
                    : Colors.white,
                foregroundColor: isDark ? Colors.white : Colors.black,
                elevation: 4,
                shadowColor: isDark
                    ? Colors.white.withOpacity(0.3)
                    : Colors.black.withOpacity(0.3),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(
                    color: isDark ? Colors.white : Colors.black,
                    width: 2,
                  ),
                ),
              ),
              child: Icon(widget.isDark ? Icons.light_mode : Icons.dark_mode),
            ),
          ),
        ],
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
