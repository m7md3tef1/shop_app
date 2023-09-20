part of 'register_cubit.dart';




abstract class ShopRegisterStates {}

class RegisterInitial extends ShopRegisterStates {}
class ShopRegisterLoadingState extends ShopRegisterStates {}

class ShopRegisterSuccessState extends ShopRegisterStates {
  final ShopLoginModel loginModel;
  ShopRegisterSuccessState(this.loginModel);
}

class ShopRegisterErrorState extends ShopRegisterStates {
  final String error;
  ShopRegisterErrorState(this.error);
}
class ShopChangePasswordVisibilityState extends ShopRegisterStates {}