import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/component/constant.dart';
import 'package:shop_app/component/toast.dart';
import 'package:shop_app/modules/login/login_cubit.dart';
import 'package:shop_app/modules/register/register.dart';
import 'package:shop_app/shared/cacheHelper.dart';

import '../../component/router.dart';
import '../../widgets/customtextfile.dart';
import '../layout/layout.dart';

class ShopLoginScreen extends StatelessWidget {
   ShopLoginScreen({super.key});

  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (context, state) {
          if (ShopLoginCubit.get(context).shopLoginModel?.status == true) {
            CacheHelper.saveData(
                    key: 'token',
                    value:
                        ShopLoginCubit.get(context).shopLoginModel?.data!.token)
                .then((value) {
              token = ShopLoginCubit.get(context).shopLoginModel!.data!.token!;
              MagicRouter.navigateAndPopAll(const ShopLayout());
            });
          } else if (ShopLoginCubit.get(context).shopLoginModel?.status ==
              false) {
            showToast(
                msg: ShopLoginCubit.get(context)
                    .shopLoginModel!
                    .message
                    .toString(),
                state: ToastedStates.ERROR);
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LOGIN',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(color: Colors.black),
                        ),
                        Text(
                          'LOGIN now to browse our hot offers',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(color: Colors.grey),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        CustomTextFormField(
                          type: TextInputType.emailAddress,
                          controller: emailController,
                          label: 'Email Address',
                          validator: (value) {
                            if (value.toString().isEmpty) {
                              return 'please enter your email address';
                            }
                            return null;
                          },
                          icondata: Icons.email,
                          secure: false,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        CustomTextFormField(
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          label: 'Password',
                          onSubmit: (value) {
                            if (formKey.currentState!.validate()) {
                              ShopLoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text);
                            }
                          },
                          suffix: IconButton(
                            icon: Icon(ShopLoginCubit.get(context).suffix),
                            onPressed: () {
                              ShopLoginCubit.get(context)
                                  .changePasswordVisibility();
                            },
                          ),
                          validator: (value) {
                            if (value.toString().isEmpty) {
                              return 'password is too short';
                            }
                            return null;
                          },
                          icondata: Icons.lock,
                          secure: ShopLoginCubit.get(context).isPassword,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopLoginLoadingState,
                          builder: (context) => InkWell(
                            onTap: () {
                              if (formKey.currentState!.validate()) {
                                ShopLoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text);
                              }
                            },
                            child: Container(
                              height: 50,
                              color: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(.8),
                              child: Center(
                                child: Text(
                                  'LOGIN',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall!
                                      .copyWith(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          fallback: (context) => const Center(
                            child: CircularProgressIndicator(
                              color: Colors.deepPurple,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Don\'t have an account?'),
                            TextButton(
                                onPressed: () {
                                  MagicRouter.navigateTo(
                                       RegisterScreen());
                                },
                                child: Text('Register'.toUpperCase()))
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
