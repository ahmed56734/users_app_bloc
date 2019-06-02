import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

class UsersApi {
  static const _authority = "reqres.in";
  static const _BASE_URL = "https://$_authority/api";

  final http.Client _client = http.Client();

  Future<http.Response> getUsers({@required int page}) {
    final uri = Uri.https(_authority, "/api/users", {"page": page.toString()});
    return _client.get(uri.toString());
  }

  getUser(String userId) async {
    return await _client.get("$_BASE_URL/user/$userId");
  }
}
