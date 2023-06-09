
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/modules/new_post/new_post_screen.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/components/constants.dart';
import 'package:social_app/shared/style/icon_broken.dart';

import 'cubit/states.dart';

class SocialLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var cubit = AppCubit.get(context);
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if(state is NewPostState){
          navigateTo(context, NewPostScreen());
        }
      },
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          title: Text(cubit.titles[cubit.currentIndex]),
          actions: [
            IconButton(onPressed: (){},
                icon: Icon(IconBroken.Notification,),),
            IconButton(onPressed: (){}, icon: Icon(IconBroken.Search,),),
            IconButton(onPressed: (){
              signOut(context);
            }, icon: Icon(IconBroken.Logout,),),
          ],
        ),
        body: ConditionalBuilder(
            condition: AppCubit.get(context).userModel != null,
            builder: (context) => cubit.Screens[cubit.currentIndex],
            fallback: (context) => Center(child: CircularProgressIndicator()),
            ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: cubit.currentIndex,
          onTap: (index){
            cubit.changeBottomNave(index);
          },
          items: [
            BottomNavigationBarItem(icon: Icon(IconBroken.Home),label: 'Home'),
            BottomNavigationBarItem(icon: Icon(IconBroken.Chat),label: 'Chats'),
            BottomNavigationBarItem(icon: Icon(IconBroken.Upload),label: 'Post'),
            BottomNavigationBarItem(icon: Icon(IconBroken.User),label: 'Users'),
            BottomNavigationBarItem(icon: Icon(IconBroken.Setting),label: 'Settings'),
          ],
        ),
      ),
    );
  }
}
