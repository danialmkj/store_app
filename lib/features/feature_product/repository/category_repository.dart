// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';
import 'package:store_app/common/error_handling/app_exception.dart';
import 'package:store_app/common/error_handling/check_exceptions.dart';
import 'package:store_app/common/resources/data_state.dart';
import 'package:store_app/features/feature_product/data/data_source/category_api_provider.dart';
import 'package:store_app/features/feature_product/data/models/category_model.dart';

class CategoryRepository {
  
  CategoryApiProvider categoryApiProvider;
  
  CategoryRepository({
    required this.categoryApiProvider,
  });

  Future<DataState<CategoriesModel>> fetchCategoryData()async{

    try {

    Response response = await categoryApiProvider.callCategories();

    CategoriesModel categoriesModel = CategoriesModel.fromJson(response.data);

    return DataSuccess(categoriesModel);


    } on AppException catch (e) {

      return await CheckExceptions.getError(e);
    }


    
  }

}
