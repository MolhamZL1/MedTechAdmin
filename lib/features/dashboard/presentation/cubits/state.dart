import '../../domain/entities/offer_entity.dart';

abstract class AdvertisementState {}

class AdvertisementInitial extends AdvertisementState {}

// حالات جلب قائمة الإعلانات
class AdvertisementLoading extends AdvertisementState {}
class AdvertisementSuccess extends AdvertisementState {
  final List<AdvertisementEntity> advertisements;
  AdvertisementSuccess(this.advertisements);
}
class AdvertisementFailure extends AdvertisementState {
  final String errMessage;
  AdvertisementFailure(this.errMessage);
}

// حالات إنشاء إعلان جديد
class CreateAdvertisementLoading extends AdvertisementState {}
class CreateAdvertisementSuccess extends AdvertisementState {
  final AdvertisementEntity newAdvertisement;
  CreateAdvertisementSuccess(this.newAdvertisement);
}
class CreateAdvertisementFailure extends AdvertisementState {
  final String errMessage;
  CreateAdvertisementFailure(this.errMessage);
}
