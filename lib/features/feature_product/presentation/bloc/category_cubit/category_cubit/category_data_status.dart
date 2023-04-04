part of 'category_cubit.dart';

@immutable
abstract class CategoryDataStatus {}

class CategoryDataInitial extends CategoryDataStatus {}

class CategoryDataLoading extends CategoryDataStatus {}

class CategoryDataComplete extends CategoryDataStatus {
  final CategoriesModel categoriesModel;

  CategoryDataComplete(this.categoriesModel);
}

class CategoryDataError extends CategoryDataStatus {
  final String message;

  CategoryDataError(this.message);
}

