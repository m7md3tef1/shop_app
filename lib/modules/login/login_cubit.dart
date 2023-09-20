import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/models/Login_model.dart';
import 'package:shop_app/shared/dio_helper.dart';

part 'login_state.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(LoginInitial());
  static ShopLoginCubit get(context) => BlocProvider.of(context);
  ShopLoginModel? shopLoginModel;
  void userLogin({
    required String email,
    required String password,
  }) {
    emit(ShopLoginLoadingState());
    DioHelper.postData(url: 'login', data: {
      'email': email,
      'password': password,
    }).then((value) {
      if (kDebugMode) {
        print(value.data);
      }
      shopLoginModel = ShopLoginModel.fromJson(value.data);
      if (kDebugMode) {
        print(shopLoginModel!.data!.token);
        print(shopLoginModel!.message);
        print(shopLoginModel!.status);
      }
      emit(ShopLoginSuccessState(shopLoginModel!));

    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(ShopLoginErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ShopChangePasswordVisibilityState());
  }
}
