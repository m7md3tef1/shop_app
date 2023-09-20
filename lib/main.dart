import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/modules/layout/shop_cubit.dart';
import 'package:shop_app/modules/login/login.dart';
import 'package:shop_app/modules/login/login_cubit.dart';
import 'package:shop_app/shared/bloc_observer.dart';
import 'package:shop_app/shared/cacheHelper.dart';
import 'package:shop_app/shared/dio_helper.dart';

import 'component/constant.dart';
import 'component/router.dart';
import 'modules/layout/layout.dart';
import 'modules/on_boarding/on_boarding.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();
  await DioHelper.init();
  await CacheHelper.init();
  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
   token = CacheHelper.getData(key: 'token');
  print(token);
  // print(onBoarding);
  Widget widget;
  if (onBoarding != null) {
    if (token != null) {
      widget = const ShopLayout();
    } else {
      widget =  ShopLoginScreen();
    }
  } else {
    widget = const OnBoardingScreen();
  }
  runApp(MyApp(startWidget: widget));
}

class MyApp extends StatelessWidget {
  final Widget? startWidget;
  const MyApp({super.key, this.startWidget});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider(create: (_) => ShopLoginCubit()),
        BlocProvider(
            create: (_) => ShopCubit()
              ..getHomeData()
              ..getCategories()
              ..getFavorites()
              ..getUserData()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: startWidget,
      ),
    );
  }
}
