import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/shared/style/icon_broken.dart';

import '../../shared/components/components.dart';

class EditeProfileScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var bioController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = AppCubit.get(context).userModel;
        var profileImage = AppCubit.get(context).profileImage;
        var coverImage = AppCubit.get(context).coverImage;

        nameController.text = userModel.name;
        bioController.text = userModel.bio;
        phoneController.text = userModel.phone;

        return Scaffold(
          appBar: defaultAppBar(
            context: context,
            title: 'Edite Profile',
            actions: [
              defaultTextButton(
                onPressed: () {
                  AppCubit.get(context).updateUser(
                      name: nameController.text,
                      bio: bioController.text,
                      phone: phoneController.text);
                },
                text: 'UPDATE',
              ),
              SizedBox(
                width: 10.0,
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  if (state is UpdateUserLoadingState)
                    LinearProgressIndicator(),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    height: 190.0,

                    //Cover And Profile Images
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topCenter,

                          //Cover Image
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
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
                                      image: coverImage == null
                                          ? NetworkImage(
                                              '${userModel.cover}',
                                            )
                                          : FileImage(coverImage),
                                      fit: BoxFit.cover),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  AppCubit.get(context).getCoverImage();
                                },
                                icon: CircleAvatar(
                                    radius: 20.0,
                                    child: Icon(
                                      IconBroken.Camera,
                                      size: 18.0,
                                    )),
                              ),
                            ],
                          ),
                        ),

                        //Profile Image
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 54.0,
                              backgroundColor: Colors.white,
                              child: CircleAvatar(
                                //backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                                radius: 50.0,
                                backgroundImage: profileImage == null
                                    ? NetworkImage(
                                        '${userModel.image}',
                                      )
                                    : FileImage(profileImage),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                AppCubit.get(context).getProfileImage();
                              },
                              icon: CircleAvatar(
                                  radius: 20.0,
                                  child: Icon(
                                    IconBroken.Camera,
                                    size: 18.0,
                                  )),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  if (AppCubit.get(context).profileImage != null ||
                      AppCubit.get(context).coverImage != null)
                    Row(
                      children: [
                        if (AppCubit.get(context).profileImage != null)
                          Expanded(
                            child: Column(
                              children: [
                                defaultButton(
                                  onPressed: () {
                                    AppCubit.get(context).uploadProfileImage(
                                        name: nameController.text,
                                        bio: bioController.text,
                                        phone: phoneController.text);
                                  },
                                  text: 'UPLOAD PROFILE',
                                  height: 40.0,
                                ),
                                if (state is UpdateUserLoadingState)
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                if (state is UpdateUserLoadingState)
                                  LinearProgressIndicator(),
                              ],
                            ),
                          ),
                        SizedBox(
                          width: 10.0,
                        ),
                        if (AppCubit.get(context).coverImage != null)
                          Expanded(
                            child: Column(
                              children: [
                                defaultButton(
                                  onPressed: () {
                                    AppCubit.get(context).uploadCoverImage(
                                      name: nameController.text,
                                      bio: bioController.text,
                                      phone: phoneController.text,
                                    );
                                   },
                                  text: 'UPLOAD COVER',
                                  height: 40.0,
                                ),
                                if (state is UpdateUserLoadingState)
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                if (state is UpdateUserLoadingState)
                                  LinearProgressIndicator(),
                              ],
                            ),
                          ),
                      ],
                    ),
                  SizedBox(
                    height: 15.0,
                  ),
                  defaultFormField(
                    controller: nameController,
                    type: TextInputType.name,
                    validate: (String value) {
                      if (value.isEmpty) {
                        return 'Name must not br empty';
                      }
                      return null;
                    },
                    label: 'Name',
                    prefix: IconBroken.User,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  defaultFormField(
                    controller: bioController,
                    type: TextInputType.text,
                    validate: (String value) {
                      if (value.isEmpty) {
                        return 'Bio must not br empty';
                      }
                      return null;
                    },
                    label: 'Bio',
                    prefix: IconBroken.Info_Circle,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  defaultFormField(
                    controller: phoneController,
                    type: TextInputType.phone,
                    validate: (String value) {
                      if (value.isEmpty) {
                        return 'Phone number must not br empty';
                      }
                      return null;
                    },
                    label: 'Phone',
                    prefix: IconBroken.Call,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
