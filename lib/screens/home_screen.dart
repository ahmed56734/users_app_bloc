import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiwi/kiwi.dart' as kiwi;
import 'package:users_bloc/blocs/users_bloc.dart';
import 'package:users_bloc/data/models/user.dart';
import 'package:users_bloc/screens/details_screen.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "home";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  final UsersBloc _usersBloc = kiwi.Container().resolve();

  @override
  void initState() {
    super.initState();
    _usersBloc.dispatch(UsersEvent.LoadNextPage);
  }

  @override
  Widget build(BuildContext context) {
//    final UsersBloc _usersBloc = BlocProvider.of<UsersBloc>(context);
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder(
          bloc: _usersBloc,
          builder: (BuildContext context, UsersState state) {
            if (state is UsersUninitialized) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is UsersLoaded) {
              return ListView.builder(
                  controller: _scrollController,
                  itemCount:
                      state.users.length + (state.shouldLoadMore ? 1 : 0),
                  itemBuilder: (BuildContext context, int index) {
                    if (index < state.users.length) {
                      return _userListItem(state.users[index], context);
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  });
            } else {
              return Text("error");
            }
          }),
    );
  }

  Widget _userListItem(User user, BuildContext context) {
    return ListTile(
      leading: Hero(
        tag: user.avatar,
        child: CircleAvatar(
          backgroundColor: Colors.amber,
          backgroundImage: CachedNetworkImageProvider(user.avatar),
        ),
      ),
      title: Text(user.firstName),
      onTap: () {
        Navigator.pushNamed(context, DetailsScreen.routeName, arguments: user);
      },
    );
  }
}
