import 'package:flutter/material.dart';
import 'package:users_bloc/data/models/user.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:users_bloc/utils/constants.dart';

class DetailsScreen extends StatelessWidget {
  static const routeName = 'details';
  final User user;

  DetailsScreen(BuildContext context)
      : user = ModalRoute.of(context).settings.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              SizedBox(
                height: 400,
                child: ClipPath(
                  clipper: _MyCustomClipper(),
                  child: WaveBackground(),
                ),
              ),
              Container(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 16),
                    Hero(
                      tag: user.avatar,
                      child: CircleAvatar(
                        radius: 90,
                        backgroundImage:
                            CachedNetworkImageProvider(user.avatar),
                      ),
                    ),
                    SizedBox(height: 32),
                    Text(
                      "${user.firstName} ${user.lastName}",
                      style: kDetailsTextStyle,
                    ),
                    SizedBox(height: 8),
                    Text(
                      user.email,
                      style: kDetailsTextStyle,
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class _MyCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.relativeLineTo(0, size.height);
    path.relativeLineTo(size.width, -size.height * .25);

    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

class WaveBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WaveWidget(
      config: CustomConfig(
        gradients: [
          [Colors.red, Color(0xEEF44336)],
          [Colors.red[800], Color(0x77E57373)],
          [Colors.orange, Color(0x66FF9800)],
          [Colors.yellow, Color(0x55FFEB3B)]
        ],
        durations: [35000, 19440, 10800, 6000],
        heightPercentages: [0.20, 0.23, 0.25, 0.30],
        blur: MaskFilter.blur(BlurStyle.solid, 10),
        gradientBegin: Alignment.bottomLeft,
        gradientEnd: Alignment.topRight,
      ),
      waveAmplitude: 0,
      backgroundColor: Colors.blue,
      size: Size(
        double.infinity,
        double.infinity,
      ),
    );
  }
}
