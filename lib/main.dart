import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(
    const App(),
  );
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Geolocator HotReload Test'),
      ),
      body: Column(
        children: [
          FutureBuilder(
            future: Geolocator.getCurrentPosition(timeLimit: const Duration(seconds: 20)),
            builder: (context, snap) {
              if (snap.hasError) {
                return Center(
                  child: Text(snap.error.toString()),
                );
              } else if (snap.hasData) {
                return Center(
                  child: Text(snap.data.toString()),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
          const RepaintBoundary(child:  PermissionText()),
        ],
      ),
    );
  }

}


class PermissionText extends StatefulWidget {
  const PermissionText({Key? key}) : super(key: key);

  @override
  State<PermissionText> createState() => _PermissionTextState();
}

class _PermissionTextState extends State<PermissionText> {
  String permissionStatus = 'Unknown';

  @override
  void initState() {
    getPermission();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Text(permissionStatus);
  }
  
  void getPermission() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      Geolocator.checkPermission().then((value) {
        setState(() {
          permissionStatus = '$value ${DateTime.now()}';
        });
      });
    });
  }
}
