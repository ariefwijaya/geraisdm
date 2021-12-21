import '../config/themes/theme_config.dart';
import '../env/env.dart';
import 'settings/models/language_model.dart';

/// The class where the centralized configuration is set.
/// This can be changed before built
class AppSetting {
  AppSetting._();

  /// This is Base URL for RestFul API
  static String get baseUrl => Env.baseUrl;

  /// Flag to show debug logs when its set to true
  static bool get showLog => Env.showLog;

  /// Internet connection lookup
  static String get serverHostLookup => Env.serverHostLookup;

  /// Maximum timeout when connect to Restful API
  static int get apiConnectTimeout => Env.apiConnectTimeout;

  /// Maximum timeout when receiving response from Restful API
  static int get apiReceiveTimeout => Env.apiReceiveTimeout;

  /// Default Size of pagination if not set
  static int get defaultPaginationLimit => Env.defaultPaginationLimit;

  /// Default language for this app localizations.
  /// Default to `id => Bahasa Indonesia`
  static final LanguageModel defaultLanguage = supportedLanguageList[0];

  /// List of available languanges in this app.
  static final List<LanguageModel> supportedLanguageList = <LanguageModel>[
    LanguageModel(languageCode: 'id', name: 'Bahasa Indonesia'),
    LanguageModel(languageCode: 'en', name: 'English')
  ];

  /// Default theme Style for this app [AppTheme.primaryLight]
  static const AppTheme defaultTheme = AppTheme.primaryLight;

  static const String currencySymbol = 'Rp ';
}
