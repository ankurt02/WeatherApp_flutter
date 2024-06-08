import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weatherapp/screens/home.screen.dart';
import 'package:device_preview/device_preview.dart';


// to use the device previewer, uncomment the below code
// void main()  async {
//   await dotenv.load(fileName : "assets/.env");
//   runApp(
//   DevicePreview(
//     // enabled: !kReleaseMode,
//     builder: (context) => MyApp(), // Wrap your app
//   ),
// );}


// when using device preview, comment out the below code, and use the above main() function
void main() async {
  await dotenv.load(fileName: "assets/.env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
