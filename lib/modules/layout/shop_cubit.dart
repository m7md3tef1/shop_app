import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shop_app/component/constant.dart';
import 'package:shop_app/models/Login_model.dart';
import 'package:shop_app/models/categories_model/CategorirsModel.dart';
import 'package:shop_app/models/favorite_model/FavoriteModel.dart';
import 'package:shop_app/models/home_model/Home_model.dart';
import 'package:shop_app/modules/categories/categories_screen.dart';
import 'package:shop_app/modules/favorites/favorites_screen.dart';
import 'package:shop_app/modules/products/prosucts_screen.dart';
import 'package:shop_app/modules/setting/setting_screen.dart';
import 'package:shop_app/shared/dio_helper.dart';

import '../../models/change_favorites_model.dart';

part 'shop_state.dart';

class ShopCubit extends Cubit<ShopState> {
  ShopCubit() : super(ShopInitial());
  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> bottomScreen = [
    const ProductsScreen(),
    const CategoriesScreen(),
    const FavoritesScreen(),
    SettingScreen()
  ];
  void changeBottom(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  HomeModel? homeModel;
  void getHomeData() {
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(
      url: 'home',
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      homeModel!.data!.products!.forEach((element) {
        favourites.addAll({
          element.id!: element.inFavorites!,
        });
      });

      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(ShopFailedHomeDataState());
    });
  }

  CategoriesModel? categoriesModel;
  void getCategories() {
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(
      url: 'categories',
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);

      emit(ShopSuccessCategoriesState());
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(ShopFailedCategoriesState());
    });
  }

  ChangeFavoritesModel? changeFavoritesModel;
  Map<int, bool> favourites = {};
  void changeFavorites(int productId) {
    favourites[productId] = !favourites[productId]!;

    emit(ShopChangeFavoritesState());
    DioHelper.postData(
      url: 'favorites',
      data: {
        'product_id': productId,
      },
      token: token,
    ).then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);

      printFullText(changeFavoritesModel!.message.toString());
      if (!changeFavoritesModel!.status!) {
        favourites[productId] = !favourites[productId]!;
      } else {
        getFavorites();
      }

      emit(ShopSuccessChangeFavoritesState(changeFavoritesModel!));
    }).catchError((error) {
      favourites[productId] = !favourites[productId]!;

      emit(ShopFailedChangeFavoritesState());
    });
  }

  FavoriteModel? favoriteModel;
  void getFavorites() {
    emit(ShopLoadingGetFavoritesState());
    DioHelper.getData(url: 'favorites', token: token).then((value) {
      favoriteModel = FavoriteModel.fromJson(value.data);
      emit(ShopSuccessGetFavoritesState());
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(ShopFailedGetFavoritesState());
    });
  }

  ShopLoginModel? loginModel;
  void getUserData() {
    emit(ShopLoadingUserDataState());
    DioHelper.getData(url: 'profile', token: token).then((value) {
      loginModel = ShopLoginModel.fromJson(value.data);
      print(loginModel!.data!.email.toString());
      emit(ShopSuccessUserDataState(loginModel!));
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(ShopFailedUserDataState());
    });
  }

  void updateUserData({
    required String name,
    required String email,
    required String phone,
  }) {
    emit(ShopLoadingUpdateDataState());
    DioHelper.putData(
      url: 'update-profile',
      token: token,
      data: {
        'name': name,
        'email': email,
        'phone': phone,
      },
    ).then((value) {
      loginModel = ShopLoginModel.fromJson(value.data);
      printFullText(loginModel!.data!.email.toString());
      emit(ShopSuccessUpdateDataState(loginModel!));
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(ShopFailedUpdateDataState());
    });
  }
}
