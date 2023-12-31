part of 'login_cubit.dart';

@immutable
abstract class ShopLoginStates {}

class LoginInitial extends ShopLoginStates {}
class ShopLoginLoadingState extends ShopLoginStates {}

class ShopLoginSuccessState extends ShopLoginStates {
  final ShopLoginModel loginModel;
  ShopLoginSuccessState(this.loginModel);
}

class ShopLoginErrorState extends ShopLoginStates {
  final String error;
  ShopLoginErrorState(this.error);
}
class ShopChangePasswordVisibilityState extends ShopLoginStates {}