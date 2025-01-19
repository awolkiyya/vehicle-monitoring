import 'package:get/get.dart';
import 'package:mini_project/commens/routes/name.dart';
import 'package:mini_project/pages/dashboard/index.dart';

class RoutePage{
  final String initialPage = RouteName.Initial;
  static final List<GetPage> pageRoute = [
    // this is for onboarding screen for the app
    GetPage(
      name: RouteName.Initial,
      page: () {
        return  Dashboard();
      },
      binding: VehicleBinding(),
      transition: Transition.zoom,
    ),
  ];
    
}