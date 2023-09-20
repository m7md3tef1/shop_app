import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/component/router.dart';

import '../models/favorite_model/Product.dart';
import '../modules/layout/shop_cubit.dart';
import '../modules/login/login.dart';
import '../shared/cacheHelper.dart';

void signOut(context) {
  CacheHelper.removeData(key: 'token').then((value) {
    if (value) {
      MagicRouter.navigateAndPopAll(ShopLoginScreen());
    }
  });
}

void printFullText(String text) {
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match) {
    if (kDebugMode) {
      print(match.group(0));
    }
  });
}

String token = '';
Widget buildListProduct(
  model,
  context, {
  bool isOldSearch = true,
}) =>
    Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: 120,
        child: Row(
          children: [
            Stack(alignment: AlignmentDirectional.bottomStart, children: [
              Image(
                image: NetworkImage(model.image.toString() == null
                    ? 'https://student.valuxapps.com/storage/uploads/products/1644375298DjMDB.14.jpg'
                    : model!.image.toString()),
                width: 120,
                height: 120,
              ),
              if (model.discount != 0 && isOldSearch)
                Container(
                  color: Colors.red,
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: const Text(
                    'DISCOUNT',
                    style: TextStyle(
                      fontSize: 8,
                      color: Colors.white,
                    ),
                  ),
                ),
            ]),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name != null ? model.name.toString() : 'title',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      height: 1.3,
                    ),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Text(
                        model.price != null
                            ? model.price!.round().toString()
                            : 'price',
                        style: const TextStyle(
                            fontSize: 14,
                            height: 1.3,
                            color: Colors.deepPurple),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      if (model.discount != 0 && isOldSearch)
                        Text(
                          model.oldPrice != null
                              ? model.oldPrice!.round().toString()
                              : 'oldPrice',
                          style: const TextStyle(
                              fontSize: 10,
                              decoration: TextDecoration.lineThrough,
                              //  height: 1.3,
                              color: Colors.grey),
                        ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          ShopCubit.get(context).changeFavorites(model.id!);
                        },
                        icon: CircleAvatar(
                          radius: 15,
                          backgroundColor:
                              ShopCubit.get(context).favourites[model.id]!
                                  ? Colors.deepPurple
                                  : Colors.grey,
                          child: const Icon(
                            Icons.favorite_border,
                            size: 12,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
