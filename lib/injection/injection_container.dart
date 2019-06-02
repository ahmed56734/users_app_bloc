import 'package:kiwi/kiwi.dart' as kiwi;
import 'package:users_bloc/blocs/users_bloc.dart';
import 'package:users_bloc/data/users_api.dart';
import 'package:users_bloc/data/users_repository.dart';

void initKiwi() {
  kiwi.Container().registerSingleton((c) => UsersApi());

  kiwi.Container()
      .registerSingleton((c) => UsersRepository(usersApi: c.resolve()));

  kiwi.Container()
      .registerSingleton((c) => UsersBloc(usersRepository: c.resolve()));
}
