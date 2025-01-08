import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_redux/flutter_redux.dart' as flutter_redux;
import 'package:passmana/data_object_box/object_box.dart';
import 'package:passmana/domain_redux/app_middleware.dart';
import 'package:passmana/domain_redux/app_reducer.dart';
import 'package:passmana/domain_redux/app_state.dart';
import 'package:passmana/domain_redux/card/card_middleware.dart';
import 'package:passmana/domain_redux/filter_search/filter_search_middleware.dart';
import 'package:passmana/domain_redux/group/group_middleware.dart';
import 'package:passmana/domain_redux/password/password_middleware.dart';
import 'package:passmana/domain_redux/secret_note/secret_note_middleware.dart';
import 'package:passmana/domain_redux/user/user_actions.dart';
import 'package:passmana/domain_redux/user/user_middleware.dart';
import 'package:passmana/localization/app_localization.dart';
import 'package:passmana/router/router.dart';
import 'package:passmana/utility/app_theme.dart';
import 'package:passmana/utility/constants.dart';
import 'package:redux/redux.dart' as redux;

//provide access to the objectbox store throughout the app
late ObjectBox objectBox;

Future<void> main() async {
  //this is required so object box can get the application directory
  //to store the database by creating different sub directory in application directory
  WidgetsFlutterBinding.ensureInitialized();
  objectBox = await ObjectBox.create();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final store = redux.Store<AppState>(
    appReducer,
    initialState: AppState(),
    middleware: createStoreMiddleware()
      ..addAll(
        createUserMiddleware()
          ..addAll(createPasswordMiddleware())
          ..addAll(createGroupMiddleware())
          ..addAll(createCardMiddleware())
          ..addAll(createSecretNoteMiddleware())
          ..addAll(createFilterSearchMiddleware()),
      ),
  );

  @override
  Widget build(BuildContext context) {
    return flutter_redux.StoreProvider<AppState>(
      store: store,
      child: flutter_redux.StoreConnector<AppState, String>(
        onInit: (redux.Store<AppState> store) {
          store.dispatch(LoadUser());
        },
        converter: (redux.Store<AppState> store) {
          return store.state.user?.localeString ?? AppConstants.english;
        },
        builder: (context, localeString) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: ThemeMode.system,
            locale: Locale(localeString),
            supportedLocales: const [
              Locale(AppConstants.english),
              Locale(AppConstants.hindi),
              Locale(AppConstants.gujarati),
            ],
            localizationsDelegates: [
              AppLocalizationDelegate(),
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            localeResolutionCallback: (locale, supportedLocales) {
              for (var supportedLocale in supportedLocales) {
                if (supportedLocale.languageCode == locale?.languageCode && supportedLocale.countryCode == locale?.countryCode) {
                  return supportedLocale;
                }
              }
              return supportedLocales.first;
            },
            routeInformationProvider: router.routeInformationProvider,
            routeInformationParser: router.routeInformationParser,
            routerDelegate: router.routerDelegate,
          );
        },
      ),
    );
  }
}
