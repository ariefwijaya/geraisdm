import 'package:auto_route/auto_route.dart';
import '../../../../modules/home_layout/screens/home_layout_screen.dart';
import '../../../../modules/onboarding/screens/onboarding_screen.dart';
import '../../../../modules/login/screens/login_screen.dart';
import '../../../../modules/register/screens/register_screen.dart';
import '../../../../modules/splash/splash_screen.dart';

// @CupertinoAutoRouter
// @AdaptiveAutoRouter
// @CustomAutoRouter
//@MaterialAutoRouter
@CupertinoAutoRouter(
  replaceInRouteName: 'Screen,Route',
  routes: <AutoRoute>[
    AutoRoute(path: "/splash-screen", page: SplashScreen),
    AutoRoute(path: "/login", page: LoginScreen),
    AutoRoute(path: "/register", page: RegisterScreen),
    AutoRoute(path: "/onboarding", page: OnboardingScreen),
    AutoRoute(path: "/menu", page: HomeLayoutScreen),
  ],
)
class $AppRouter {}
