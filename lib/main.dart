import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiwi/kiwi.dart' as kiwi;
import 'package:users_bloc/blocs/bloc_delegate.dart';
import 'package:users_bloc/blocs/users_bloc.dart';
import 'package:users_bloc/screens/details_screen.dart';
import 'package:users_bloc/screens/home_screen.dart';

import 'injection/injection_container.dart';

void main() {
  initKiwi();
  BlocSupervisor.delegate = AppBlocDelegate();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProviderTree(
      blocProviders: [
        BlocProvider<UsersBloc>(
          bloc: kiwi.Container().resolve<UsersBloc>(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: HomeScreen.routeName,
        routes: {
          HomeScreen.routeName: (buildContext) => HomeScreen(),
          DetailsScreen.routeName: (buildContext) =>
              DetailsScreen(buildContext),
        },
      ),
    );
  }
}
