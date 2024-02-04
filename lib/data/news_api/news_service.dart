import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:primal_analytics/common/util/local_json.dart';

mixin NewsService {
  String get newsApiKey => dotenv.env['news-api-key']!;
  String get newsBaseUrl => dotenv.env['news-api']!;

  Future<List<T>> fetchHeadlines<T>() async {
    final http.Response response;
    response = await http.get(
        Uri.parse('$newsBaseUrl/top-headlines?country=kr&apiKey=$newsApiKey'));

    return LocalJson.fetchKoreanObjectList<T>(response);
  }
}
