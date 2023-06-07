import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/shared/style/icon_broken.dart';

import '../../shared/components/components.dart';

class NewPostScreen extends StatelessWidget {
  var textController = TextEditingController();
  var now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: defaultAppBar(
            context: context,
            title: 'Add Post',
            actions: [
              defaultTextButton(
                onPressed: () {
                  if (AppCubit.get(context).postsImage == null) {
                    AppCubit.get(context).createPost(
                      text: textController.text,
                      dateTime: now.toString(),
                    );
                  } else {
                    AppCubit.get(context).uploadPostImage(
                      text: textController.text,
                      dateTime: now.toString(),
                    );
                  }
                },
                text: 'POST',
              ),
            ],
          ),
          body: LayoutBuilder(
          builder: (context, constraint) {
        return SingleChildScrollView(
        child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: constraint.maxHeight),
        child: IntrinsicHeight(
        child:  Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (state is CreatePostLoadingState ||
                        state is CreatePostImageLoadingState)
                      LinearProgressIndicator(),
                    if (state is CreatePostLoadingState ||
                        state is CreatePostImageLoadingState)
                      SizedBox(
                        height: 10.0,
                      ),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 25.0,
                          backgroundImage: NetworkImage(
                            '${AppCubit.get(context).userModel.image}',
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
                            Text(
                              'Public',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 13.0,
                                height: 1.3,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    Expanded(
                      child: TextFormField(
                        keyboardType: TextInputType.multiline,
                        minLines: 1,//Normal textInputField will be displayed
                        maxLines: 5,// when user presses enter it will adapt to it
                        controller: textController,
                        decoration: InputDecoration(
                          hintText: 'Whats is on your mind',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    if (AppCubit.get(context).postsImage != null)
                      Expanded(
                        child: Stack(
                          alignment: AlignmentDirectional.topEnd,
                          children: [
                            Container(
                              height: 150.0,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  4.0,
                                ),
                                image: DecorationImage(
                                  image: FileImage(
                                    AppCubit.get(context).postsImage,
                                  ),
                                  fit: BoxFit.cover,),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                AppCubit.get(context).removePostImage();
                              },
                              icon: CircleAvatar(
                                radius: 20.0,
                                child: Icon(
                                  IconBroken.Close_Square,
                                  size: 18.0,
                                ),),
                            ),
                          ],
                        ),
                      ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextButton(
                            onPressed: () {
                              AppCubit.get(context).getPostImage();
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  IconBroken.Image,
                                ),
                                SizedBox(
                                  width: 5.0,
                                ),
                                Text(
                                  'Add photo',
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: TextButton(
                            onPressed: () {},
                            child: Text(
                              '# tags',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

        ),
        ),
        );
        },),

        );
      },
    );
  }
}

