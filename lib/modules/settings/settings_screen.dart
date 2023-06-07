import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/style/icon_broken.dart';

import '../edite_profile/edit_profile_screen.dart';

class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = AppCubit.get(context).userModel;

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                height: 190.0,
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Align(
                      alignment: AlignmentDirectional.topCenter,
                      child: Container(
                        height: 150.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(
                              4.0,
                            ),
                            topRight: Radius.circular(
                              4.0,
                            ),
                          ),
                          image: DecorationImage(
                              image: NetworkImage(
                                '${userModel.cover},',
                              ),
                              fit: BoxFit.cover),
                        ),
                      ),
                    ),
                    CircleAvatar(
                      radius: 54.0,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        //backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                        radius: 50.0,
                        backgroundImage: NetworkImage(
                          '${userModel.image},',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Text('${userModel.name}',
                  style: TextStyle(
                    fontSize: 18.0,
                  )),
              Text(
                '${userModel.bio}',
                style: TextStyle(
                    //fontWeight: FontWeight.bold,
                    fontSize: 14.0,
                    color: Colors.grey),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text('100',
                                style: TextStyle(
                                    //fontSize: 18.0,
                                    )),
                            Text(
                              'Posts',
                              style: TextStyle(
                                  //fontWeight: FontWeight.bold,
                                  //fontSize: 14.0,
                                  color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text('100',
                                style: TextStyle(
                                    //fontSize: 18.0,
                                    )),
                            Text(
                              'Posts',
                              style: TextStyle(
                                  //fontWeight: FontWeight.bold,
                                  //fontSize: 14.0,
                                  color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text('100',
                                style: TextStyle(
                                    //fontSize: 18.0,
                                    )),
                            Text(
                              'Posts',
                              style: TextStyle(
                                  //fontWeight: FontWeight.bold,
                                  //fontSize: 14.0,
                                  color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text('100',
                                style: TextStyle(
                                    //fontSize: 18.0,
                                    )),
                            Text(
                              'Posts',
                              style: TextStyle(
                                  //fontWeight: FontWeight.bold,
                                  //fontSize: 14.0,
                                  color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {},
                      child: Text(
                        'Add Photos',
                      ),
                    ),
                  ),
                  SizedBox(width: 10.0,),
                  OutlinedButton(
                    onPressed: () {
                      navigateTo(context, EditeProfileScreen(),);
                    },
                    child: Icon(IconBroken.Edit,size: 18.0,),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
