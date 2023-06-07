import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/layout/layout.dart';
import 'package:social_app/modules/login/login_screen.dart';
import 'package:social_app/shared/bloc_observer.dart';
import 'package:social_app/shared/components/constants.dart';
import 'package:social_app/shared/network/local/cache_helper.dart';
import 'package:social_app/shared/style/themes.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  uId = CacheHelper.getData(key: 'uId');
  if(uId != null) {
    print('////////////// THE TOKEN is ////////////');
    print(uId.toString());
  }
Widget widget;
  if(uId != null) {
    widget = SocialLayout();
  } else{
    widget = LoginScreen();
  }
  runApp( MyApp(startWidget: widget,));
}

class MyApp extends StatelessWidget {

  Widget startWidget;
  MyApp({this.startWidget});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..getUserData()..getPosts()..getAllUsers(),
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context, state) {},
        builder: (context, state) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          home:  startWidget,
        ),
      ),
    );
  }
}

