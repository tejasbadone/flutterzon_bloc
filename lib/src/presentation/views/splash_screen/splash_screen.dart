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
    context.read<PageRedirectionCubit>().redirectUser();
    return Scaffold(
      body: BlocConsumer<PageRedirectionCubit, PageRedirectionState>(
          listener: (context, state) {
        if (state is PageRedirectionSuccess) {
          if (state.userType == 'admin') {
            context.goNamed(AppRouteConstants.adminBottomBarRoute.name);
          } else if (state.userType == '' || state.userType == 'invalid') {
            context.goNamed(AppRouteConstants.authRoute.name);
          } else {
            context.goNamed(AppRouteConstants.bottomBarRoute.name);
          }
        }
        if (state is PageRedirectionInvalid) {
          context.goNamed(AppRouteConstants.authRoute.name);
        }
      }, builder: ((context, state) {
        return Scaffold(
          body: Center(
            child: Image.asset(
              'assets/images/amazon_in_alt.png',
              height: 52,
            ),
          ),
        );
      })),
    );
  }
}
