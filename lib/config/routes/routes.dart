import 'package:auto_route/auto_route.dart';
import 'package:geraisdm/modules/forgot_password/screens/forgot_password_screen.dart';
import 'package:geraisdm/modules/register/screens/register_verification_screen.dart';
import 'package:geraisdm/modules/register/screens/register_wrapper_screen.dart';
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
    AutoRoute(path: "/forgot-password", page: ForgotPasswordScreen),
    AutoRoute(
        path: "/register",
        name: "RegisterRouter",
        page: RegisterWrapperScreen,
        children: [
          AutoRoute(path: '', page: RegisterScreen),
          AutoRoute(
              path: "verification",
              //need guards
              page: RegisterVerificationScreen),
          RedirectRoute(path: '*', redirectTo: ''),
        ]),
    AutoRoute(path: "/onboarding", page: OnboardingScreen),
    AutoRoute(path: "/menu", page: HomeLayoutScreen),
  ],
)
class $AppRouter {}
