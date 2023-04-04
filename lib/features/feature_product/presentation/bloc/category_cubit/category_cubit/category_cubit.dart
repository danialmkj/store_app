import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:store_app/common/resources/data_state.dart';
import 'package:store_app/features/feature_product/data/models/category_model.dart';
import 'package:store_app/features/feature_product/repository/category_repository.dart';

part 'category_state.dart';
part 'category_data_status.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryRepository categoryRepository;

  CategoryCubit(this.categoryRepository)
      : super(CategoryState(categoryDataStatus: CategoryDataLoading()));

  Future<void> loadCategoryEvent() async {
    //loading
    emit(state.copyWith(newCategoryDataStatus: CategoryDataLoading()));

    DataState dataState = await categoryRepository.fetchCategoryData();

    //complete
    if (dataState is DataSuccess) {
      emit(state.copyWith(
          newCategoryDataStatus: CategoryDataComplete(dataState.data)));

      //error
    }
    if (dataState is DataFailed) {
      emit(state.copyWith(
          newCategoryDataStatus: CategoryDataError(dataState.error!)));
    }
  }
}
