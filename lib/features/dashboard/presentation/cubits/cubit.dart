import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_tech_admin/features/dashboard/presentation/cubits/state.dart';

import '../../domain/repos/offer_repo.dart';


class AdvertisementCubit extends Cubit<AdvertisementState> {
  final AdvertisementRepo advertisementRepo;
  AdvertisementCubit(this.advertisementRepo) : super(AdvertisementInitial());

  Future<void> fetchAdvertisements() async {
    emit(AdvertisementLoading());
    final result = await advertisementRepo.getAdvertisements();
    result.fold(
          (failure) => emit(AdvertisementFailure(failure.errMessage)),
          (ads) => emit(AdvertisementSuccess(ads)),
    );
  }

  Future<void> createAd({
    required String title,
    required String bio,
    required Uint8List imageBytes,
    required String imageName,
  }) async {
    emit(CreateAdvertisementLoading());
    final result = await advertisementRepo.createAdvertisement(
      title: title,
      bio: bio,
      imageBytes: imageBytes,
      imageName: imageName,
    );
    result.fold(
          (failure) => emit(CreateAdvertisementFailure(failure.errMessage)),
          (newAd) {
        // بعد النجاح، أعد جلب القائمة المحدثة
        fetchAdvertisements();
      },
    );
  }
}
