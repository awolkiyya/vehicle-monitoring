import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:mini_project/commens/routes/name.dart';
import 'package:mini_project/commens/routes/pages.dart';
import 'firebase_options.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      getPages:RoutePage.pageRoute, // all routePages
      initialRoute: RouteName.Initial, // initial route
      // initialBinding: , // initial binding for controller
      builder: EasyLoading.init(),
    );
  }
}
