import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

@JsonSerializable()
class User {
  @JsonKey(name: "id")
  int id;

  @JsonKey(name: "email")
  String email;

  @JsonKey(name: "first_name")
  String firstName;

  @JsonKey(name: "last_name")
  String lastName;

  @JsonKey(name: "avatar")
  String avatar;

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    avatar = json['avatar'];
  }
}

class UsersResponse {
  int page;
  int perPage;
  int total;
  int totalPages;
  List<User> data;

  UsersResponse.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    perPage = json['per_page'];
    total = json['total'];
    totalPages = json['total_pages'];

    final usersList = json['data'] as List;
    data = usersList.map((i) => User.fromJson(i)).toList();
  }
}
