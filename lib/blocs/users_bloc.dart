import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:users_bloc/data/models/user.dart';
import 'package:users_bloc/data/users_repository.dart';

import 'users_event.dart';
import 'users_state.dart';

export 'users_event.dart';
export 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  final UsersRepository _usersRepository;
  int _currentPage;

  UsersBloc({@required UsersRepository usersRepository})
      : _usersRepository = usersRepository;

  @override
  UsersState get initialState {
    _currentPage = 1;
    return UsersUninitialized();
  }

  @override
  Stream<UsersState> mapEventToState(UsersEvent event) async* {
    switch (event) {
      case UsersEvent.LoadNextPage:
        try {
          if (currentState is UsersUninitialized) {
            final response =
                await _usersRepository.getUsers(page: _currentPage);
            yield UsersLoaded(users: response.data, shouldLoadMore: true);
            dispatch(UsersEvent.LoadNextPage);
          } else if (currentState is UsersLoaded &&
              (currentState as UsersLoaded).shouldLoadMore) {
            _currentPage++;
            final response =
                await _usersRepository.getUsers(page: _currentPage);
            final shouldLoadMore = response.totalPages > _currentPage;
            final oldUsers = (currentState as UsersLoaded).users;

            yield UsersLoaded(
                users: List<User>.from(oldUsers)..addAll(response.data),
                shouldLoadMore: shouldLoadMore);
            if (shouldLoadMore) {
              dispatch(UsersEvent.LoadNextPage);
            }
          }
        } catch (e) {
          yield UsersError("");
        }
    }
  }
}
