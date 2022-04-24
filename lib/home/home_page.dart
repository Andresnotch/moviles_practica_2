import 'package:avatar_glow/avatar_glow.dart';
import 'package:findtrackapp/fav_list/fav_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../auth/bloc/auth_bloc.dart';
import 'bloc/listen_bloc.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Color _mainColor = Colors.indigo;
  String _mainHint = 'Toque para escuchar';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        //padding: EdgeInsets.all(100),
        //color: Colors.red, //DEBUG:
        width: double.infinity,
        height: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              _mainHint,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
            Container(
              padding: EdgeInsets.all(0),
              child: BlocBuilder<ListenBloc, ListenState>(
                builder: (context, state) {
                  if (state is ListeningState) {
                    return AvatarGlow(
                      endRadius: 150.0,
                      showTwoGlows: true,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Image.asset(
                          'assets/icon/icon_line.png',
                          width: 100,
                          height: 100,
                        ),
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                            CircleBorder(),
                          ),
                          fixedSize:
                              MaterialStateProperty.all(Size.fromRadius(100)),
                        ),
                      ),
                    );
                  } else {
                    return ElevatedButton(
                      onPressed: () {
                        context.read<ListenBloc>().add(ListenNowEvent());
                        setState(() {});
                      },
                      child: Image.asset(
                        'assets/icon/icon_line.png',
                        width: 100,
                        height: 100,
                      ),
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                          CircleBorder(),
                        ),
                        fixedSize:
                            MaterialStateProperty.all(Size.fromRadius(100)),
                      ),
                    );
                  }
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FavoriteList(),
                      ),
                    );
                  },
                  child: Icon(
                    Icons.favorite,
                    color: Colors.black,
                  ),
                  style: ButtonStyle(
                    overlayColor: MaterialStateProperty.all(
                        Color.fromARGB(255, 182, 193, 255)),
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    shape: MaterialStateProperty.all(
                      CircleBorder(),
                    ),
                    fixedSize: MaterialStateProperty.all(Size.fromRadius(10)),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    BlocProvider.of<AuthBloc>(context).add(SignOutEvent());
                  },
                  child: Icon(
                    Icons.power_settings_new,
                    color: Colors.black,
                  ),
                  style: ButtonStyle(
                    overlayColor: MaterialStateProperty.all(
                        Color.fromARGB(255, 182, 193, 255)),
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    shape: MaterialStateProperty.all(
                      CircleBorder(),
                    ),
                    fixedSize: MaterialStateProperty.all(Size.fromRadius(10)),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      backgroundColor: Color.fromARGB(255, 44, 44, 44),
    );
  }
}
