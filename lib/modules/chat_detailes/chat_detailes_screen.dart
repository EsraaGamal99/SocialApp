import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/shared/style/colors.dart';

import '../../models/messages_model.dart';
import '../../shared/components/constants.dart';
import '../../shared/style/icon_broken.dart';

class ChatDetailsScreen extends StatelessWidget {
   UserModel userModel;

   ChatDetailsScreen({
    this.userModel,
  });
   var messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
          AppCubit.get(context).getMessages(receiverId: userModel.uId);
        return BlocConsumer<AppCubit,AppStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                titleSpacing: 0.0,
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 20.0,
                      backgroundImage: NetworkImage(
                        '${userModel.image}',
                      ),
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    Expanded(
                      child: Text(
                        '${userModel.name}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          //fontSize: 14.0,
                          height: 1.4,
                        ),
                      ),
                    ),
                    TextButton(onPressed: (){AppCubit.get(context).removeChat(receiverId: userModel.uId);}, child: Text('Remove'),),
                  ],
                ),
              ),
              body: ConditionalBuilder(
                condition: AppCubit.get(context).message.length > 0,
                builder: (context) => Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                          itemBuilder:(context, index) {
                            var message = AppCubit.get(context).message[index];

                            if(AppCubit.get(context).userModel.uId== message.senderId)
                              return buildMyMessage(context,message);
                            return buildMessage(userModel,message);
                          },
                          separatorBuilder: (context, index) => SizedBox(height: 5.0,),
                          itemCount: AppCubit.get(context).message.length,),
                      ),

                      Container(
                        height: 50.0,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            20.0,
                          ),
                          border: Border.all(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsetsDirectional.only(
                                  start: 10.0,
                                ),
                                child: TextFormField(
                                  controller: messageController,
                                  minLines: 1,
                                  maxLines: 5,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Message',
                                  ),
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                AppCubit.get(context).sendMessage(
                                  receiverId: userModel.uId,
                                  dateTime: DateTime.now().toString(),
                                  msg: messageController.text,
                                );
                                clearText(controller: messageController);
                              },
                              icon: Icon(IconBroken.Send),
                              color: Colors.teal,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                fallback: (context) => Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 50.0,
                          backgroundImage: NetworkImage(
                            '${userModel.image}',
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text('${userModel.name}'),
                        SizedBox(width: 20.0,),
                        Text('No messages yet.',style: TextStyle(color: Colors.grey),),
                        Spacer(),
                        Container(
                          height: 50.0,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              20.0,
                            ),
                            border: Border.all(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.only(
                                    start: 10.0,
                                  ),
                                  child: TextFormField(
                                    controller: messageController,
                                    minLines: 1,
                                    maxLines: 5,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Message',
                                    ),
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  AppCubit.get(context).sendMessage(
                                    receiverId: userModel.uId,
                                    dateTime: DateTime.now().toString(),
                                    msg: messageController.text,
                                  );
                                  clearText(controller: messageController);
                                },
                                icon: Icon(IconBroken.Send),
                                color: Colors.teal,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

Widget buildMessage(UserModel userModel,MessageModel messageModel) => Row(
      children: [
        CircleAvatar(
          radius: 15.0,
          backgroundImage: NetworkImage(
            '${userModel.image}',
          ),
        ),
        SizedBox(
          width: 2.0,
        ),
        Container(
          padding: EdgeInsetsDirectional.symmetric(
            vertical: 5.0,
            horizontal: 10.0,
          ),
          decoration: BoxDecoration(
            color: favColor,
            borderRadius: BorderRadiusDirectional.all(
              Radius.circular(15.0),
            ),
          ),
          child: Text(
            messageModel.msg,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );

Widget buildMyMessage(context, MessageModel messageModel) => Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          padding: EdgeInsetsDirectional.symmetric(
            vertical: 5.0,
            horizontal: 10.0,
          ),
          decoration: BoxDecoration(
            color: selectedItemColor,
            borderRadius: BorderRadiusDirectional.all(
              Radius.circular(15.0),
            ),
          ),
          child: Text(
            messageModel.msg,
            style: TextStyle(color: Colors.white),
          ),
        ),
        SizedBox(
          width: 2.0,
        ),
        CircleAvatar(
          radius: 15.0,
          backgroundImage: NetworkImage(
            '${AppCubit.get(context).userModel.image}',
          ),
        ),
      ],
    );
