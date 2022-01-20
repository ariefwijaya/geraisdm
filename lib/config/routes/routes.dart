import 'package:auto_route/auto_route.dart';
import 'package:geraisdm/config/routes/routes_config.dart';
import 'package:geraisdm/modules/announcement/screens/announcement_detail_screen.dart';
import 'package:geraisdm/modules/announcement/screens/announcement_screen.dart';
import 'package:geraisdm/modules/announcement/screens/announcement_wrapper_screen.dart';
import 'package:geraisdm/modules/articles/screens/article_detail_screen.dart';
import 'package:geraisdm/modules/articles/screens/article_screen.dart';
import 'package:geraisdm/modules/articles/screens/article_wrapper_screen.dart';
import 'package:geraisdm/modules/bookmark/screens/bookmark_screen.dart';
import 'package:geraisdm/modules/complaint/screens/complain_screen.dart';
import 'package:geraisdm/modules/detail_menu/screens/detail_menu_screen.dart';
import 'package:geraisdm/modules/detail_menu/screens/detail_menu_tnc_screen.dart';
import 'package:geraisdm/modules/doc_viewer/screens/doc_viewer_detail_screen.dart';
import 'package:geraisdm/modules/doc_viewer/screens/doc_viewer_screen.dart';
import 'package:geraisdm/modules/forgot_password/screens/forgot_password_screen.dart';
import 'package:geraisdm/modules/form_submission/screens/form_submission_screen.dart';
import 'package:geraisdm/modules/history/screens/history_detail_screen.dart';
import 'package:geraisdm/modules/history/screens/history_screen.dart';
import 'package:geraisdm/modules/history/screens/history_survey_screen.dart';
import 'package:geraisdm/modules/history/screens/history_wrapper_screen.dart';
import 'package:geraisdm/modules/home/screens/home_screen.dart';
import 'package:geraisdm/modules/inbox/screens/inbox_detail_screen.dart';
import 'package:geraisdm/modules/inbox/screens/inbox_screen.dart';
import 'package:geraisdm/modules/profile/screens/profile_biodata_screen.dart';
import 'package:geraisdm/modules/profile/screens/profile_password_screen.dart';
import 'package:geraisdm/modules/profile/screens/profile_screen.dart';
import 'package:geraisdm/modules/profile/screens/profile_wrapper_screen.dart';
import 'package:geraisdm/modules/register/screens/register_verification_screen.dart';
import 'package:geraisdm/modules/register/screens/register_wrapper_screen.dart';
import 'package:geraisdm/modules/submenu/screens/submenu_screen.dart';
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
    AutoRoute(path: "/submenu/:id", page: SubmenuScreen),
    AutoRoute(
        path: "/announcement",
        name: "AnnouncementRouter",
        page: AnnouncementWrapperScreen,
        children: [
          AutoRoute(path: '', page: AnnouncementScreen),
          AutoRoute(path: ":id", page: AnnouncementDetailScreen),
          RedirectRoute(path: '*', redirectTo: ''),
        ]),
    AutoRoute(
        path: "/article",
        name: "ArticleRouter",
        page: ArticleWrapperScreen,
        children: [
          AutoRoute(path: '', page: ArticleScreen),
          AutoRoute(path: ":id", page: ArticleDetailScreen),
          RedirectRoute(path: '*', redirectTo: ''),
        ]),
    AutoRoute(path: "/doc-viewer/:id", page: DocViewerScreen),
    AutoRoute(path: "/doc-viewer-detail/:id", page: DocViewerDetailScreen),
    AutoRoute(path: "/detail-menu/:id", page: DetailMenuScreen),
    AutoRoute(path: "/requirement/:id", page: DetailMenuTNCScreen),
    AutoRoute(path: "/form-submission/:id", page: FormSubmissionScreen),
    AutoRoute(path: "/inbox-detail/:id", page: InboxDetailScreen),
    AutoRoute(path: "/complaint", page: ComplaintScreen),
    AutoRoute(path: "/menu", page: HomeLayoutScreen, guards: [
      AuthGuard
    ], children: [
      AutoRoute(path: "home", page: HomeScreen),
      AutoRoute(
          path: "history",
          name: "HistoryRouter",
          page: HistoryWrapperScreen,
          children: [
            AutoRoute(path: "", page: HistoryScreen),
            AutoRoute(path: ":id", page: HistoryDetailScreen),
            AutoRoute(path: "survey", page: HistorySurveyScreen),
            RedirectRoute(path: '*', redirectTo: ''),
          ]),
      AutoRoute(path: "bookmark", page: BookmarkScreen),
      AutoRoute(path: "inbox", page: InboxScreen),
      AutoRoute(
          path: "profile",
          name: "ProfileRouter",
          page: ProfileWrapperScreen,
          children: [
            AutoRoute(
              path: "",
              page: ProfileScreen,
            ),
            AutoRoute(
              path: "biodata",
              page: ProfileBiodataScreen,
            ),
            AutoRoute(
              path: "change-password",
              page: ProfilePasswordScreen,
            ),
            RedirectRoute(path: '*', redirectTo: ''),
          ])
    ]),
  ],
)
class $AppRouter {}
