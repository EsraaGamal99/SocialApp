import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/models/user_model.dart';

class ChatsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: AppCubit.get(context).users.length > 0,
          builder: (context) => ListView.separated(
            itemBuilder: (context, index) =>
                UserItem(context, AppCubit.get(context).users[index]),
            separatorBuilder: (context, index) => Divider(),
            itemCount: AppCubit.get(context).users.length,
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}

Widget UserItem(context, UserModel model) => InkWell(
  onTap: (){},
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Esraa Gamal',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          ],
        ),
      ),
    );
