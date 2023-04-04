import 'package:bloc/bloc.dart';


class SearchboxCubit extends Cubit<bool> {
  SearchboxCubit() : super(true);


  void changeVisibility(newValue){
    emit(newValue);
  }
}
