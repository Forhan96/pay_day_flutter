import 'package:fluro/fluro.dart';
import 'package:pay_day/src/routes/routes.dart';
import 'package:pay_day/src/screens/home_screen/home_screen.dart';
import 'package:pay_day/src/utils/debugger.dart';

class RouterHelper {
  static final FluroRouter router = FluroRouter();

  static final Handler _homeScreenHandler = Handler(handlerFunc: (context, parameters) => const HomeScreen());

  static final Handler _notFoundHandler = Handler(handlerFunc: (context, parameters) {
    Debugger.debug(title: "Router", data: "No Router Found!");
    return null;
  });

  void setupRouter() {
    router.define(Routes.homeScreen, handler: _homeScreenHandler, transitionType: TransitionType.cupertino);

    router.notFoundHandler = _notFoundHandler;
  }
}
