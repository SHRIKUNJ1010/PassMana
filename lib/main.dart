import 'package:flutter/material.dart';
import 'package:passmana/data_object_box/object_box.dart';
import 'package:passmana/domain_redux/app_middleware.dart';
import 'package:passmana/domain_redux/app_state.dart';
import 'package:passmana/domain_redux/app_reducer.dart';
import 'package:passmana/domain_redux/group/group_middleware.dart';
import 'package:passmana/domain_redux/password/password_middleware.dart';
import 'package:passmana/domain_redux/user/user_middleware.dart';
import 'package:passmana/router/router.dart';
import 'package:passmana/utility/color.dart';
import 'package:redux/redux.dart' as redux;
import 'package:flutter_redux/flutter_redux.dart' as flutter_redux;

//provide access to the objectbox store throughout the app
late ObjectBox objectBox;

Future<void> main() async {
  //this is required so object box can get the application directory
  //to store the database by creating different sub directory in application directory
  WidgetsFlutterBinding.ensureInitialized();
  objectBox = await ObjectBox.create();
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
          ..addAll(createGroupMiddleware()),
      ),
  );

  @override
  Widget build(BuildContext context) {
    return flutter_redux.StoreProvider<AppState>(
      store: store,
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: AppColors.primaryMaterialColor,
          useMaterial3: true,
          colorSchemeSeed: AppColors.primaryMaterialColor,
        ),
        routeInformationProvider: router.routeInformationProvider,
        routeInformationParser: router.routeInformationParser,
        routerDelegate: router.routerDelegate,
      ),
    );
  }
}
