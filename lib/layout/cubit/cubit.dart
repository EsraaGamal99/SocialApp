import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/models/post_model.dart';
import 'package:social_app/modules/chats/chats_screen.dart';
import 'package:social_app/modules/feeds/feeds_screen.dart';
import 'package:social_app/modules/new_post/new_post_screen.dart';
import 'package:social_app/modules/settings/settings_screen.dart';
import 'package:social_app/modules/users/users_screen.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../../models/user_model.dart';
import '../../shared/components/constants.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(GetUserInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> Screens = [
    FeedsScreen(),
    ChatsScreen(),
    NewPostScreen(),
    UsersScreen(),
    SettingScreen(),
  ];

  List<String> titles = ['Home', 'Chats', 'New Post', 'Users', 'Settings'];

  void changeBottomNave(index) {
    if(index == 1)
      getAllUsers();
    if (index == 2) {
      emit(NewPostState());
    } else {
      currentIndex = index;
      emit(ChangeNavBarState());
    }
  }

  UserModel userModel;

  void getUserData() {
    emit(GetUserLoadingState());

    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      userModel = UserModel.fromJson(value.data());
      emit(GetUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetUserErrorState(error.toString()));
    });
  }

  File profileImage;
  var picker = ImagePicker();

  Future<void> getProfileImage() async {
    final pickFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickFile != null) {
      profileImage = File(
        pickFile.path,
      );
      emit(ImagePicSuccessState());
    } else {
      print(
        'No image selected',
      );
      emit(ImagePicErrorState());
    }
  }

  File coverImage;

  Future<void> getCoverImage() async {
    final pickFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickFile != null) {
      coverImage = File(
        pickFile.path,
      );
      emit(CoverPicSuccessState());
    } else {
      print(
        'No image selected',
      );
      emit(CoverPicErrorState());
    }
  }

  void uploadProfileImage({
    @required String name,
    @required String bio,
    @required String phone,
    String image,
  }) {
    emit(UpdateUserLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child(
          'users/${Uri.file(profileImage.path).pathSegments.last}',
        )
        .putFile(profileImage)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        updateUser(
          name: userModel.name,
          bio: userModel.bio,
          phone: userModel.phone,
          image: value,
        );
        //emit(UploadProfileImageSuccessState());
      }).catchError((error) {
        emit(UploadProfileImageErrorState());
      });
    }).catchError((error) {
      emit(UploadProfileImageErrorState());
    });
  }

  void uploadCoverImage({
    @required String name,
    @required String bio,
    @required String phone,
    String cover,
  }) {
    emit(UpdateUserLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child(
          'users/${Uri.file(coverImage.path).pathSegments.last}',
        )
        .putFile(coverImage)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        updateUser(
          name: userModel.name,
          bio: userModel.bio,
          phone: userModel.phone,
          cover: value,
        );
        // emit(UploadProfileImageSuccessState());
      }).catchError((error) {
        emit(UploadProfileImageErrorState());
      });
    }).catchError((error) {
      emit(UploadProfileImageErrorState());
    });
  }

  // void updateUserImages(
  //     {
  //       @required String name,
  //       @required String bio,
  //       @required String phone
  //     })
  // {
  //   emit(UpdateUserLoadingState());
  //
  //   UserModel model = UserModel(
  //     phone: phone,
  //     email: userModel.email,
  //     name: name,
  //     uId: userModel.uId,
  //     image: userModel.image,
  //     cover: userModel.cover,
  //     bio: bio,
  //     isVerification: false,
  //   );
  //
  //   if(coverImage !=null){
  //     uploadCoverImage();
  //   }else if(profileImage !=null){
  //     uploadProfileImage();
  //   }else{
  //     updateUser(
  //       name: name,
  //       phone: phone,
  //       bio: bio,
  //     );
  //   }
  // }

  void updateUser({
    @required String name,
    @required String bio,
    @required String phone,
    String image,
    String cover,
  }) {
    UserModel model = UserModel(
      phone: phone,
      email: userModel.email,
      name: name,
      uId: userModel.uId,
      image: image ?? userModel.image,
      cover: cover ?? userModel.cover,
      bio: bio,
      isVerification: false,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel.uId)
        .update(model.toMap())
        .then((value) {
      getUserData();
    }).catchError((error) {
      emit(UpdateUserErrorState());
    });
  }

  void createPost({
    @required String text,
    @required String dateTime,
    String postImage,
  }) {
    emit(CreatePostLoadingState());

    PostModel model = PostModel(
      name: userModel.name,
      uId: userModel.uId,
      image: userModel.image,
      postImage: postImage ?? '',
      text: text,
      dateTime: dateTime,
    );

    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value) {
      emit(CreatePostSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(CreatePostErrorState());
    });
  }

  File postsImage;

  Future<void> getPostImage() async {
    final pickFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickFile != null) {
      postsImage = File(
        pickFile.path,
      );
      emit(CreatePostImageSuccessState());
    } else {
      print(
        'No image selected',
      );
      emit(CreatePostImageErrorState());
    }
  }

  void uploadPostImage({
    @required String text,
    @required String dateTime,
  }) {
    emit(CreatePostImageLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child(
          'posts/${Uri.file(postsImage.path).pathSegments.last}',
        )
        .putFile(postsImage)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        createPost(
          text: text,
          dateTime: dateTime,
          postImage: value,
        );
      }).catchError((error) {
        print(error.toString());
        emit(CreatePostImageErrorState());
      });
    }).catchError((error) {
      emit(CreatePostImageErrorState());
    });
  }

  void removePostImage() {
    postsImage = null;
    emit(RemovePostImageState());
  }

  List<PostModel> posts = [];
  List<String> postId = [];
  List<int> likes=[];

  void getPosts() {
    emit(GetPostsLoadingState());

    FirebaseFirestore.instance
        .collection('posts')
        .get()
        .then((value) {

          value.docs.forEach((element) {
            element.reference
                .collection('likes')
                .get()
                .then((value)
            {
              likes.add(value.docs.length);
              postId.add(element.id);
              posts.add(PostModel.fromJson(element.data()));
            })
                .catchError((error){
                  print(error.toString());
            });

          });
      emit(GetPostsSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetPostsErrorState(error.toString()));
    });
  }

  void likePost(String postId){

    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userModel.uId)
        .set({
      'like':true,
    })
        .then((value) {
          emit(LikePostSuccessState());
    })
        .catchError((error){
      emit(LikePostErrorState(error.toString()));

    });
  }

  void commentPost(String postId){

    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .doc(userModel.uId)
        .set({
      'comments':true,
    })
        .then((value) {
      emit(CommentPostSuccessState());
    })
        .catchError((error){
      emit(CommentPostErrorState(error.toString()));

    });
  }

  List<UserModel> users ;

  void getAllUsers(){
    users = [];
    emit(GetAllUsersLoadingState());

    FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((value) {

      value.docs.forEach((element) {
        if(element.data()['uId'] != userModel.uId)
          users.add(UserModel.fromJson(element.data()));
      });
      emit(GetAllUsersSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetAllUsersErrorState(error.toString()));
    }); 
  }
}

///// هستدعي ابلود الصور ف الاسكرين
