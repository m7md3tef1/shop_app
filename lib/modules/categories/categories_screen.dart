import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/categories_model/DataCategory.dart';
import 'package:shop_app/modules/layout/shop_cubit.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (context, state) {},
      builder: (context, state) {
        return ListView.separated(
            itemBuilder: (context, index) => buildCatItem(
                ShopCubit.get(context).categoriesModel!.data!.data![index]),
            separatorBuilder: (context, index) => const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  child: Divider(
                    thickness: .7,
                    height: .2,
                  ),
                ),
            itemCount:
                ShopCubit.get(context).categoriesModel!.data!.data!.length);
      },
    );
  }

  Widget buildCatItem(DataCategory dataCategory) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Image(
              image: NetworkImage(dataCategory.image.toString()),
              width: 80,
              height: 80,
            ),
            const SizedBox(
              width: 20,
            ),
            Text(
              dataCategory.name.toString(),
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios),
          ],
        ),
      );
}
