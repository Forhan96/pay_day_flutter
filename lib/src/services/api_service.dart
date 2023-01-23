import 'package:http/http.dart' as http;

abstract class ApiService {
  Future<http.Response> getPosts();
}
