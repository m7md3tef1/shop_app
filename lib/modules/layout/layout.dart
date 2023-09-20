import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/layout/shop_cubit.dart';
import 'package:shop_app/modules/search/search_screen.dart';
import '../../component/router.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Salla',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  MagicRouter.navigateTo( SearchScreen());
                },
                icon: const Icon(Icons.search),
              )
            ],
          ),
          body: cubit.bottomScreen[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeBottom(index);
            },
            showUnselectedLabels: true,
            showSelectedLabels: true,
            // selectedLabelStyle: const TextStyle(
            //   color: Colors.black,
            //   fontWeight: FontWeight.w400,
            //   fontSize: 13,
            // ),
            // unselectedLabelStyle: const TextStyle(
            //   color: Colors.grey,
            //   fontSize: 13,
            //   fontWeight: FontWeight.w400,
            // ),
            selectedItemColor: Colors.deepPurple,
            unselectedItemColor: Colors.grey,
            backgroundColor: Colors.grey,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.apps),
                label: 'Categories',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: 'Favorites',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Settings',
              ),
            ],
          ),
        );
      },
    );
  }
}
