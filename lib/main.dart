import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/layout/layout.dart';
import 'package:social_app/modules/login/login_screen.dart';
import 'package:social_app/shared/bloc_observer.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/components/constants.dart';
import 'package:social_app/shared/network/local/cache_helper.dart';
import 'package:social_app/shared/style/themes.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('on BachGround Message');
  print(message.data.toString());
  showToast(msg: 'on BachGround Message', color: Colors.teal);
}
//base URL
//fcm.googleapis.com/fcm/send
void main() async{

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
   var token = await FirebaseMessaging.instance.getToken();
    print('////////////// THE Device\'s TOKEN is ////////////');
    print(token);

    //240.5

  // foreground fcm
  FirebaseMessaging.onMessage.listen((event) {
    print('on Message');
    print(event.data.toString());
    showToast(msg: 'on Message', color: Colors.teal);
  });

  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print('on Message Opened App');
    print(event.data.toString());
    showToast(msg: 'on Message Opened App', color: Colors.teal);

  });
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
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
      create: (context) => AppCubit()..getUserData()..getPosts()..getAllUsers()..getAllChats(),
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

