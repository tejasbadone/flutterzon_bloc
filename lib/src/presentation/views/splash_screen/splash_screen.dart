import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone_bloc/src/config/router/app_route_constants.dart';
import 'package:flutter_amazon_clone_bloc/src/logic/blocs/page_redirection_cubit/page_redirection_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
            future: context.read<PageRedirectionCubit>().redirectUser(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final isValid = snapshot.data![0] as bool;
                final userType = snapshot.data![1] as String;

                Future.delayed(Duration.zero, () {
                  if (isValid) {
                    if (userType == 'user') {
                      context.goNamed(AppRouteConstants.bottomBarRoute.name);
                    } else {
                      context.goNamed(AppRouteConstants.menuScreenRoute.name);
                    }
                  } else {
                    context.goNamed(AppRouteConstants.authRoute.name);
                  }
                });
              }
              return Center(
                  child: Image.asset(
                'assets/images/amazon_in_alt.png',
                height: 52,
              ));
            }));
  }
}
