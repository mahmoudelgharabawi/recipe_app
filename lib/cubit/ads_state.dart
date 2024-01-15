part of 'ads_cubit.dart';

@immutable
abstract class AdsState {}

class AdsLoading extends AdsState {}

class AdsInitial extends AdsState {
  List<Ad> ads;
  AdsInitial({required this.ads});
}
