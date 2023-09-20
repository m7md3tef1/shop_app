import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/component/constant.dart';
import 'package:shop_app/modules/layout/shop_cubit.dart';
import 'package:shop_app/widgets/customtextfile.dart';

class SettingScreen extends StatelessWidget {
  SettingScreen({super.key});
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = ShopCubit.get(context).loginModel;

        nameController.text = model!.data!.name.toString();
        emailController.text = model.data!.email.toString();
        phoneController.text = model.data!.phone.toString();

        return ConditionalBuilder(
          condition: ShopCubit.get(context).loginModel != null,
          builder: (BuildContext context) => Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    if(state is ShopLoadingUpdateDataState)
                    const LinearProgressIndicator(),
                    const SizedBox(
                      height: 20.0,
                    ),
                    CustomTextFormField(
                      controller: nameController,
                      type: TextInputType.name,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'name must not empty';
                        }
                        return null;
                      },
                      secure: false,
                      label: 'Name',
                      icondata: Icons.person,
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    CustomTextFormField(
                      controller: emailController,
                      type: TextInputType.emailAddress,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'email must not empty';
                        }
                        return null;
                      },
                      label: 'Email Address',
                      secure: false,
                      icondata: Icons.email,
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    CustomTextFormField(
                      controller: phoneController,
                      type: TextInputType.phone,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'phone must not empty';
                        }
                        return null;
                      },
                      label: 'Phone',
                      icondata: Icons.email,
                      secure: false,
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    InkWell(
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          ShopCubit.get(context).updateUserData(
                              name: nameController.text,
                              email: emailController.text,
                              phone: phoneController.text);
                        }
                      },
                      child: Container(
                        height: 50,
                        color: Theme.of(context).primaryColor.withOpacity(.8),
                        child: Center(
                          child: Text(
                            'UPDATE',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20,),
                    InkWell(
                      onTap: () {
                        signOut(context);
                      },
                      child: Container(
                        height: 50,
                        color: Theme.of(context).primaryColor.withOpacity(.8),
                        child: Center(
                          child: Text(
                            'LOGOUT',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
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
