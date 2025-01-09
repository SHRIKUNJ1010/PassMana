/*
* Created by Shrikunj Patel on 8/24/2023.
*/
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:passmana/domain_redux/app_state.dart';
import 'package:passmana/presentation/splash/splash_view_model.dart';
import 'package:passmana/utility/assets_utility/assets_paths.dart';
import 'package:passmana/utility/constants.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, SplashViewModel>(
      converter: SplashViewModel.fromStore,
      builder: (BuildContext context, SplashViewModel vm) {
        return _buildSplashImageContainer(context);
      },
      onInitialBuild: (SplashViewModel vm) {
        vm.manageNavigation.call();
      },
    );
  }

  Widget _buildSplashImageContainer(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      alignment: Alignment.center,
      child: Hero(
        tag: AppConstants.appLogo,
        child: Image.asset(AppAssets.appLogoWithText),
      ),
    );
  }
}
