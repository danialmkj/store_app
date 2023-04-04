// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'category_cubit.dart';

class CategoryState {

  CategoryDataStatus categoryDataStatus;

  CategoryState({required this.categoryDataStatus});

  CategoryState copyWith({
    CategoryDataStatus? newCategoryDataStatus,
  }) {
    return CategoryState(
      categoryDataStatus: newCategoryDataStatus ?? categoryDataStatus,
    );
  }
}
