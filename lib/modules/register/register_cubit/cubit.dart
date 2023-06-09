import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/modules/register/register_cubit/states.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  void userRegister({
    @required String email,
    @required String password,
    @required String name,
    @required String phone,
  }) {
    emit(RegisterLoadingState());

    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {

      //String id = value.user.uid;
      createUser(
        email: email,
        uId: value.user.uid,
        name: name,
        phone: phone,
      );
      //emit(RegistersSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(RegisterErrorState(error.toString()));
    });
  }

  void createUser({
    @required String email,
    @required String uId,
    @required String name,
    @required String phone,
  }) {
    UserModel model = UserModel(
      phone: phone,
      email: email,
      name: name,
      uId: uId,
      image: 'https://cdn-icons-png.flaticon.com/512/847/847969.png?w=740&t=st=1686120013~exp=1686120613~hmac=ca0d5c8214f5d5c563d6065dcdf2e669a9484b1ac0023c8b520fec708f0a6a81',
      cover: 'https://img.freepik.com/free-photo/minimal-snowflake-christmas-social-media-banner-with-design-space_53876-160638.jpg?w=1480&t=st=1686120168~exp=1686120768~hmac=c2237f9b52b6cf8587784237bd6712bd695f72a8346ab734fd2d01e178c91da0',
      bio: 'Write your bio ...',
      isVerification: false,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      emit(CreateUserSuccessState());
      emit(RegistersSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(CreateUserErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(ChangePasswordState());
  }
}
