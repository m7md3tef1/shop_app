part of 'shop_cubit.dart';

@immutable
abstract class ShopState {}

class ShopInitial extends ShopState {}

class ShopChangeBottomNavState extends ShopState {}

class ShopLoadingHomeDataState extends ShopState {}
class ShopSuccessHomeDataState extends ShopState {}
class ShopFailedHomeDataState extends ShopState {}

class ShopSuccessCategoriesState extends ShopState {}
class ShopFailedCategoriesState extends ShopState {}


class ShopChangeFavoritesState extends ShopState {}
class ShopSuccessChangeFavoritesState extends ShopState {
  final ChangeFavoritesModel model;
  ShopSuccessChangeFavoritesState(this.model);
}
class ShopFailedChangeFavoritesState extends ShopState {}

class ShopLoadingGetFavoritesState extends ShopState {}
class ShopSuccessGetFavoritesState extends ShopState {}
class ShopFailedGetFavoritesState extends ShopState {}

class ShopLoadingUserDataState extends ShopState {}
class ShopSuccessUserDataState extends ShopState {
  final ShopLoginModel loginModel;

  ShopSuccessUserDataState(this.loginModel);
}
class ShopFailedUserDataState extends ShopState {}

class ShopLoadingUpdateDataState extends ShopState {}
class ShopSuccessUpdateDataState extends ShopState {
  final ShopLoginModel loginModel;

  ShopSuccessUpdateDataState(this.loginModel);
}
class ShopFailedUpdateDataState extends ShopState {}