import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/modules/test.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/style/colors.dart';
import 'package:social_app/shared/style/icon_broken.dart';
import '../../models/post_model.dart';
import '../comments/comments_screan.dart';

class FeedsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) => ConditionalBuilder(
        condition: (AppCubit.get(context).posts.length > 0 ),
        builder: (context) => SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                elevation: 5.0,
                margin: EdgeInsets.all(
                  8.0,
                ),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Stack(
                  alignment: AlignmentDirectional.centerEnd,
                  children: [
                    Image(
                      height: 210.0,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      image: NetworkImage(
                          'https://img.freepik.com/free-photo/bearded-man-denim-shirt-round-glasses_273609-11770.jpg?w=996&t=st=1685760978~exp=1685761578~hmac=c5e3e058338f5366f031512646fe9ee48778dbd8956966eae5b00c1d9f712cbc'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        right: 10.0,
                      ),
                      child: Text(
                        'Communicate with friends',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                  ],
                ),
              ),
              ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) =>
                    buildPostItem(context, AppCubit.get(context).posts[index],index),
                separatorBuilder: (context, index) => SizedBox(
                  height: 10.0,
                ),
                itemCount: AppCubit.get(context).posts.length,
              ),
              SizedBox(
                height: 10.0,
              ),
            ],
          ),
        ),
        fallback: (context) => Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

var commentController = TextEditingController();

Widget buildPostItem(context, PostModel postModel , index) => Card(
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
                  backgroundImage: NetworkImage(
                      '${postModel.image}'
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
                            '${postModel.name}' ,
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
                        '${postModel.dateTime}' ,
                        style: TextStyle(color: Colors.grey,height: 1.3),
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
            // Padding(
            //   padding: const EdgeInsets.only(bottom: 10.0, top: 0.5),
            //   child: Container(
            //     width: double.infinity,
            //     child: Wrap(
            //       //crossAxisAlignment: WrapCrossAlignment.start,
            //       children: [
            //         Padding(
            //           padding: const EdgeInsetsDirectional.only(
            //             end: 6.0,
            //           ),
            //           child: Container(
            //             height: 20.0,
            //             child: MaterialButton(
            //               minWidth: 1.0,
            //               padding: EdgeInsets.zero,
            //               onPressed: () {},
            //               child: Text(
            //                 '#Software',
            //                 style: TextStyle(
            //                   color: defaultColor,
            //                 ),
            //               ),
            //             ),
            //           ),
            //         ),
            //         Padding(
            //           padding: const EdgeInsetsDirectional.only(
            //             end: 6.0,
            //           ),
            //           child: Container(
            //             height: 20.0,
            //             child: MaterialButton(
            //               minWidth: 1.0,
            //               padding: EdgeInsets.zero,
            //               onPressed: () {},
            //               child: Text(
            //                 '#Software',
            //                 style: TextStyle(
            //                   color: defaultColor,
            //                 ),
            //               ),
            //             ),
            //           ),
            //         ),
            //         Padding(
            //           padding: const EdgeInsetsDirectional.only(
            //             end: 6.0,
            //           ),
            //           child: Container(
            //             height: 20.0,
            //             child: MaterialButton(
            //               minWidth: 1.0,
            //               padding: EdgeInsets.zero,
            //               onPressed: () {},
            //               child: Text(
            //                 '#Software',
            //                 style: TextStyle(
            //                   color: defaultColor,
            //                 ),
            //               ),
            //             ),
            //           ),
            //         ),
            //         Padding(
            //           padding: const EdgeInsetsDirectional.only(
            //             end: 6.0,
            //           ),
            //           child: Container(
            //             height: 20.0,
            //             child: MaterialButton(
            //               minWidth: 1.0,
            //               padding: EdgeInsets.zero,
            //               onPressed: () {},
            //               child: Text(
            //                 '#Software',
            //                 style: TextStyle(
            //                   color: defaultColor,
            //                 ),
            //               ),
            //             ),
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            if(postModel.postImage != '')
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
                    image: NetworkImage(
                        '${postModel.postImage}'
                    ),
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
                          Text('${AppCubit.get(context).likes[index]}',
                            style: TextStyle(color: Colors.grey,),
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            'Likes',
                            style: TextStyle(color: Colors.grey,),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            IconBroken.Chat,
                            size: 18.0,
                            color: Colors.amber,
                          ),
                          SizedBox(
                            width: 5.0,
                          ),

                          Text(
                            '0',
                            style: TextStyle(color: Colors.grey,),
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            'comments',
                            style: TextStyle(color: Colors.grey,),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Divider(),
            Row(
              children: [
                InkWell(
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                            '${AppCubit.get(context).userModel.image}' ,),                        radius: 15.0,
                      ),
                      SizedBox(
                        width: 10.0,
                      ),

                      Text(

                        'Write a comment ...',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  onTap: () {
                    navigateTo(context, Commentsection());

                  },
                ),
                SizedBox(
                  width: 30.0,
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      AppCubit.get(context).likePost(AppCubit.get(context).postId[index],);
                    },
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
                            'Like',
                            style: TextStyle(color: Colors.grey,),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Row(
                        children: [
                          Icon(
                            IconBroken.Upload,
                            size: 18.0,
                            color: Colors.green,
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            'Share',
                            style: TextStyle(color: Colors.grey,),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
