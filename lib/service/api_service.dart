import 'package:dio/dio.dart';
import 'package:quotii/model/quote_model.dart';

class ApiService {
  final Dio _dio = Dio();

  Future fetchQuotes() async {
    final response = await _dio.get(
      'https://motivational-spark-api.vercel.app/api/quotes/random/10',
    );
    final data = response.data as List;

    return data.map((quote) {
      return QuoteModel(quote: quote["quote"], author: quote["author"]);
    }).toList();
  }
}
