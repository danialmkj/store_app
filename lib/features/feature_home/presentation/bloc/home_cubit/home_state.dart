// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_cubit.dart';

class HomeState {
  HomeDataStatus homeDataStatus;

  HomeState({
    required this.homeDataStatus,
  });

  HomeState copyWith({
    HomeDataStatus? newHomeDataStatus,
  }) {
    return HomeState(
      homeDataStatus: newHomeDataStatus ?? homeDataStatus,
    );
  }
}
