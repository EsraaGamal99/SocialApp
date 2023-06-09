import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/models/post_model.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/modules/feeds/feeds_screen.dart';

import '../shared/components/components.dart';
import '../shared/style/colors.dart';
import '../shared/style/icon_broken.dart';

List<comment> lt = List<comment>.generate(10, (index) => comment('p1'));

// List<comment> lt =[
//   comment('p1'),
//
// ];

class Commentsection extends StatelessWidget {
  UserModel userModel;
  PostModel postModel;
  Commentsection({
    this.userModel,
    this.postModel,
});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        PostModel postModel;
        return Scaffold(
          appBar: AppBar(
            title: Text('Comments'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // ListView.separated(
                //   shrinkWrap: true,
                //   physics: NeverScrollableScrollPhysics(),
                //   itemBuilder: (context, index) => PostItem(
                //       context, AppCubit.get(context).posts[index], index),
                //   separatorBuilder: (context, index) => SizedBox(
                //     height: 0.0,
                //   ),
                //   itemCount: 1,
                // ),
                Expanded(
                  child: ListView(
                    children: lt,
                  ),
                ),
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.only(top: 16.0, bottom: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(
                          width: 60,
                          child: CircleAvatar(
                            radius: 20,
                            backgroundImage:
                                NetworkImage('${AppCubit.get(context).userModel.image}'),
                          )),
                      Expanded(
                          child: SizedBox(
                        height: 35.0,
                        child: TextField(
                          autofocus: true,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            hintText: 'add your comment',
                            suffix: IconButton(onPressed: (){},icon:Icon(IconBroken.Arrow___Right),),
                          ),
                        ),
                      ))
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class comment extends StatelessWidget {
  String person;

  comment(this.person);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        padding: EdgeInsets.fromLTRB(4.0, 12.0, 4.0, 12.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(
                        '${AppCubit.get(context).userModel.image}'),
                  ),
                ),
                Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${AppCubit.get(context).userModel.name}',
                              style: TextStyle(
                                  fontSize: 15.0, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '8h ago',
                              style: TextStyle(fontSize: 8.0),
                            ),
                          ],
                        ),
                        Text(
                          "helo its first comment As an intellectual object, a book is prototypically a composition of such great length that it takes a considerable investment of time to compose ",
                          style: TextStyle(fontSize: 10.0),
                        ),
                      ]),
                ),
                Divider(
                  color: Color(0x9c000000),
                  height: 10.0,
                )
              ],
            ),
          ],
        ));
  }
}

Widget PostItem(context, PostModel postModel, index) => Padding(
      padding: const EdgeInsetsDirectional.only(top: 8.0, bottom: 10.0),
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 10.0,
        margin: EdgeInsets.symmetric(
          horizontal: 8.0,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 25.0,
                    backgroundImage: NetworkImage('${postModel.image}'

                        // '${userModel.image}',

                        ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              '${postModel.name}',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            Icon(
                              Icons.check_circle,
                              color: defaultColor,
                              size: 17.0,
                            ),
                          ],
                        ),
                        Text(
                          '${postModel.dateTime}',
                          style: TextStyle(color: Colors.grey, height: 1.3),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      IconBroken.More_Circle,
                      size: 20.0,
                    ),
                  ),
                ],
              ),

              Divider(),

              Text(
                '${postModel.text}',
                style: Theme.of(context).textTheme.bodyMedium.copyWith(
                      height: 1.4,
                    ),
              ),


              if (postModel.postImage != '')
                Padding(
                  padding: const EdgeInsetsDirectional.only(
                    top: 15.0,
                  ),
                  child: Container(
                    height: 140.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        10.0,
                      ),
                      image: DecorationImage(
                        image: NetworkImage('${postModel.postImage}'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),

              Row(
                children: [
                  Expanded(
                    child: InkWell(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Row(
                            children: [
                              Icon(
                                IconBroken.Heart,
                                size: 18.0,
                                color: selectedItemColor,
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                '${AppCubit.get(context).likes[index]}',
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                'Likes',
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        )),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
