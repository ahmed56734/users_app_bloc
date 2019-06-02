import 'package:meta/meta.dart';
import 'package:users_bloc/data/models/user.dart';

abstract class UsersState {}

class UsersUninitialized extends UsersState {
  @override
  String toString() {
    return 'UsersUninitialized{}';
  }
}

class UsersError extends UsersState {
  final String errorMessage;

  UsersError(this.errorMessage);

  @override
  String toString() {}
}

class UsersLoaded extends UsersState {
  final List<User> users;
  final bool shouldLoadMore;

  UsersLoaded({@required this.users, @required this.shouldLoadMore});

  @override
  String toString() {
    return 'UsersLoaded{users: $users, shouldLoadMore: $shouldLoadMore}';
  }
}
