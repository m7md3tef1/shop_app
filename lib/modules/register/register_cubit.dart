import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/models/Login_model.dart';
import 'package:shop_app/shared/dio_helper.dart';


part 'register_state.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates> {
  ShopRegisterCubit() : super(RegisterInitial());
  static ShopRegisterCubit get(context) => BlocProvider.of(context);
  ShopLoginModel? shopRegisterModel;
  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,

  }) {
    emit(ShopRegisterLoadingState());
    DioHelper.postData(url: 'register', data: {
      'name': name,
      'email': email,
      'phone': phone,
      'password': password,
    }).then((value) {
      if (kDebugMode) {
        print(value.data);
      }
      shopRegisterModel = ShopLoginModel.fromJson(value.data);
      emit(ShopRegisterSuccessState(shopRegisterModel!));

    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(ShopRegisterErrorState(error.toString()));
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
