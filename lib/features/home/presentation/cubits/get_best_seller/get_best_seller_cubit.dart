import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ketaby/features/home/data/repositories/get_best_seller_repository.dart';
import 'package:ketaby/features/home/presentation/cubits/get_best_seller/get_best_seller_states.dart';

class GetBestSellerCubit extends Cubit<GetBestSellerStates> {
  GetBestSellerCubit() : super(GetBestSellerInitialState());

  static GetBestSellerCubit get(context) => BlocProvider.of(context);

  void getBestSeller() async{
    try {
      emit(GetBestSellerLoadingState());
      final bestSellerBooks = await GetBestSellerRepository.getBestSeller();
      emit(GetBestSellerSuccessState(bestSellerBooks: bestSellerBooks));
    } on SocketException catch (_) {
      emit(GetBestSellerErrorState(errorMessage: "No internet connection"));
    } catch (e) {
      emit(GetBestSellerErrorState(errorMessage: "Something went wrong"));
    }
  }
}
