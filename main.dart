import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'pages/weather_pages.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const PermissionHandler(),
    );
  }
}

class PermissionHandler extends StatefulWidget {
  const PermissionHandler({super.key});

  @override
  _PermissionHandlerState createState() => _PermissionHandlerState();
}

class _PermissionHandlerState extends State<PermissionHandler> {
  @override
  void initState() {
    super.initState();
    _requestPermissions();
  }

  Future<void> _requestPermissions() async {
    PermissionStatus status = await Permission.location.request();

    if (status.isGranted) {
      // Permission granted
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const WeatherPages()),
      );
    } else if (status.isDenied) {
      // Permission denied
      print('Location permission denied');
    } else if (status.isPermanentlyDenied) {
      // Permission permanently denied
      openAppSettings();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
