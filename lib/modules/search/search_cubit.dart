import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shop_app/component/constant.dart';
import 'package:shop_app/models/search_model/search_model.dart';
import 'package:shop_app/shared/dio_helper.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel? model;

  void search(String? text) {
    emit(SearchLoadingState());
    DioHelper.postData(
      url: 'products/search',
      token: token,
      data: {
        'text': text,
      },
    ).then((value) {
      model = SearchModel.fromJson(value.data);
      printFullText(value.data.toString());
      emit(SearchSuccessState());
    }).catchError((error) {
      printFullText(error.toString());
      emit(SearchFailedState());
    });
  }
}
