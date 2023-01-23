import 'package:http/http.dart' as http;
import 'package:pay_day/src/services/api_service.dart';
import 'package:pay_day/src/utils/api_constants.dart';

class ApiServiceImpl implements ApiService {
  @override
  Future<http.Response> getPosts() async {
    Uri url = Uri.parse(ApiConstants.baseUrl + ApiConstants.posts);
    http.Response response = await http.get(url);
    return response;
  }
}
