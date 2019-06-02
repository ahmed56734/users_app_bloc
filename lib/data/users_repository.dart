import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:users_bloc/data/models/user.dart';
import 'package:users_bloc/data/users_api.dart';

class UsersRepository {
  final UsersApi _usersApi;

  UsersRepository({@required UsersApi usersApi}) : this._usersApi = usersApi;

  Future<UsersResponse> getUsers({int page = 1}) async {
    final response = await _usersApi.getUsers(page: page);
    final jsonMap = jsonDecode(response.body);
    print(jsonMap);
    return UsersResponse.fromJson(jsonMap);
  }
}
