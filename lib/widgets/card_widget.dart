import 'package:flutter/material.dart';
import 'package:quotii/model/quote_model.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CardWidget extends StatefulWidget {
  final QuoteModel quote;

  const CardWidget({required this.quote, super.key});

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    _checkIfFavorite();
  }

  _checkIfFavorite() async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = prefs.getStringList('favorites') ?? [];
    final quoteString = '${widget.quote.quote} - ${widget.quote.author}';
    setState(() {
      isFavorite = favorites.contains(quoteString);
    });
  }

  _toggleFavorite() async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = prefs.getStringList('favorites') ?? [];
    final quoteString = '${widget.quote.quote} - ${widget.quote.author}';

    if (isFavorite) {
      favorites.remove(quoteString);
    } else {
      favorites.add(quoteString);
    }

    await prefs.setStringList('favorites', favorites);

    setState(() {
      isFavorite = !isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xff1e1e1e) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? Colors.white : Colors.black,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.white.withOpacity(0.1)
                : Colors.black.withOpacity(0.1),
            offset: const Offset(4, 4),
            blurRadius: 0,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.quote.quote,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              '- ${widget.quote.author}',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.white70 : Colors.black87,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: isDark
                        ? const Color(0xff333333)
                        : const Color(0xfff0f0f0),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isDark ? Colors.white : Colors.black,
                      width: 2,
                    ),
                  ),
                  child: IconButton(
                    onPressed: _toggleFavorite,
                    icon: Icon(
                      isFavorite
                          ? Icons.favorite
                          : Icons.favorite_border_outlined,
                      color: isFavorite
                          ? Colors.red
                          : (isDark ? Colors.white : Colors.black),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Container(
                  decoration: BoxDecoration(
                    color: isDark
                        ? const Color(0xff333333)
                        : const Color(0xfff0f0f0),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isDark ? Colors.white : Colors.black,
                      width: 2,
                    ),
                  ),
                  child: IconButton(
                    onPressed: () {
                      // Copy to clipboard
                      final data =
                          '${widget.quote.quote}\n- ${widget.quote.author}';
                      Clipboard.setData(ClipboardData(text: data));
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Quote copied to clipboard!'),
                          backgroundColor: isDark
                              ? Colors.grey[800]
                              : Colors.grey[600],
                        ),
                      );
                    },
                    icon: Icon(
                      Icons.share_rounded,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
