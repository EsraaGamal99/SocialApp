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
      image: 'https://img.freepik.com/free-vector/cute-valentine-s-day-animal-couple-with-cats_23-2148820247.jpg?w=740&t=st=1685818408~exp=1685819008~hmac=bb36f26eb9cdf2e73563d6973951ef6061ad8cc913bfadbad204fb1fc810f0bb',
      cover: 'https://img.freepik.com/free-photo/cute-kitten-staring-out-window-playful-curiosity-generative-ai_188544-12520.jpg?w=1380&t=st=1685818406~exp=1685819006~hmac=1f32609e5b4302e29c691d19bc30cb014c5ae03e198774a12900c872dec09ac6',
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
