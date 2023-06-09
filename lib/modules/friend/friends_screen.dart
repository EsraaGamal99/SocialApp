import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../models/user_model.dart';
import '../../shared/components/components.dart';
import '../../shared/style/icon_broken.dart';
import '../chat_detailes/chat_detailes_screen.dart';
import '../user_profile/user_profile_screen.dart';

class FriendsScreen extends StatelessWidget {
  UserModel userModel;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: Text('Friends'),),
          body: ConditionalBuilder(
            condition: AppCubit.get(context).users.length > 0,
            builder: (context) => ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) =>
                  buildChatItem(AppCubit.get(context).users[index], context),
              separatorBuilder: (context, index) => Divider(),
              itemCount: AppCubit.get(context).users.length,
            ),
            fallback: (context) => Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }

  Widget buildChatItem(UserModel model, context) => InkWell(
    onTap: () {
      navigateTo(
        context,
        UserProfileScreen(
          userModel: model,
        ),
      );
    },
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25.0,
            backgroundImage: NetworkImage(
              '${model.image}',
            ),
          ),
          SizedBox(
            width: 15.0,
          ),
          Text(
            '${model.name}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              height: 1.4,
            ),
          ),
          Spacer(),
          OutlinedButton(
            style: ButtonStyle(
              backgroundColor:
              MaterialStatePropertyAll(Colors.blueAccent),
            ),
            onPressed: () {
              navigateTo(
                context,
                ChatDetailsScreen(
                  userModel: model,
                ),
              );
            },
            child: Icon(
              IconBroken.Chat,
              size: 30.0,
              color: Colors.white,
            ),
          ),
        ],
      ),
    ),
  );
}
