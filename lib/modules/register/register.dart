import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/register/register_cubit.dart';

import '../../component/constant.dart';
import '../../component/router.dart';
import '../../component/toast.dart';
import '../../shared/cacheHelper.dart';
import '../../widgets/customtextfile.dart';
import '../layout/layout.dart';
import '../login/login_cubit.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  var nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
        listener: (context, state) {
          if (state is ShopRegisterSuccessState){
            if (state.loginModel.status!)
            {
              CacheHelper.saveData(
                  key: 'token',
                  value:
                  state.loginModel.data!.token)
                  .then((value) {
             //   token = state.loginModel.data!.token!;
                MagicRouter.navigateAndPopAll(const ShopLayout());
              });
            }
            else {
              showToast(
                  msg: ShopRegisterCubit.get(context)
                      .shopRegisterModel!
                      .message
                      .toString(),
                  state: ToastedStates.ERROR);
            }
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
                          'REGISTER',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(color: Colors.black),
                        ),
                        Text(
                          'REGISTER now to browse our hot offers',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(color: Colors.grey),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        CustomTextFormField(
                          type: TextInputType.name,
                          controller: nameController,
                          label: 'Name',
                          validator: (value) {
                            if (value.toString().isEmpty) {
                              return 'please enter your name address';
                            }
                            return null;
                          },
                          icondata: Icons.person,
                          secure: false,
                        ),
                        const SizedBox(
                          height: 15,
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
                          onSubmit: (value) {},
                          suffix: IconButton(
                            icon: Icon(ShopRegisterCubit.get(context).suffix),
                            onPressed: () {
                              ShopRegisterCubit.get(context)
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
                          secure: ShopRegisterCubit.get(context).isPassword,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        CustomTextFormField(
                          type: TextInputType.phone,
                          controller: phoneController,
                          label: 'Phone',
                          validator: (value) {
                            if (value.toString().isEmpty) {
                              return 'please enter your phone number';
                            }
                            return null;
                          },
                          icondata: Icons.phone,
                          secure: false,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopRegisterLoadingState,
                          builder: (context) => InkWell(
                            onTap: () {
                              if (formKey.currentState!.validate()) {
                                ShopRegisterCubit.get(context).userRegister(
                                  email: emailController.text,
                                  password: passwordController.text,
                                  name: nameController.text,
                                  phone: phoneController.text,
                                );
                              }
                            },
                            child: Container(
                              height: 50,
                              color: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(.8),
                              child: Center(
                                child: Text(
                                  'REGISTER',
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
