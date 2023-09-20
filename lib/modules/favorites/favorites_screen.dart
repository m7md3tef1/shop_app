import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/favorite_model/DataFavorite.dart';
import 'package:shop_app/models/favorite_model/FavoriteModel.dart';

import '../../component/constant.dart';
import '../layout/shop_cubit.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          builder: (context) => ListView.separated(
              itemBuilder: (context, index) => buildListProduct(
                    ShopCubit.get(context).favoriteModel!.data!.data![index].product,
                    context,
                  ),
              separatorBuilder: (context, index) => const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.0),
                    child: Divider(
                      thickness: .7,
                      height: .2,
                    ),
                  ),
              itemCount:
                  ShopCubit.get(context).favoriteModel!.data!.data!.length),
          condition: state is! ShopLoadingGetFavoritesState,
          fallback: (BuildContext context) => const Center(
            child: CircularProgressIndicator(
              color: Colors.deepPurple,
            ),
          ),
        );
      },
    );
  }

}
