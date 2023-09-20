import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/search/search_cubit.dart';
import 'package:shop_app/widgets/customtextfile.dart';

import '../../component/constant.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});
  var formKey = GlobalKey<FormState>();
  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    CustomTextFormField(
                      secure: false,
                      onSubmit: (String? text) {
                        SearchCubit.get(context).search(text);
                      },
                      controller: searchController,
                      type: TextInputType.text,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'enter text to search';
                        }
                        return null;
                      },
                      label: 'Search',
                      icondata: Icons.search,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    if (state is SearchLoadingState)
                      const LinearProgressIndicator(),
                    const SizedBox(
                      height: 10,
                    ),
                    if (state is SearchSuccessState)
                      Expanded(
                        child: ListView.separated(
                            itemBuilder: (context, index) => buildListProduct(
                                  SearchCubit.get(context)
                                      .model!
                                      .data!
                                      .data![index],
                                  context,
                                  isOldSearch: false,
                                ),
                            separatorBuilder: (context, index) =>

                            const Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 15.0),
                                  child: Divider(
                                    thickness: .7,
                                    height: .2,
                                  ),
                                ),
                            itemCount: SearchCubit.get(context)
                                .model!
                                .data!
                                .data!
                                .length),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
