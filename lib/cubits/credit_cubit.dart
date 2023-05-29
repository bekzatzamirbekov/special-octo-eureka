import 'dart:developer';

import 'package:bloc/bloc.dart';

import '../models/credit_mbank.dart';
import '../services/api_service.dart';

class CreditState {
  final List<CreditMbank> credits;
  final bool isLoading;
  final String errorMessage;

  CreditState({
    required this.credits,
    required this.isLoading,
    required this.errorMessage,
  });

  CreditState.initial()
      : credits = [],
        isLoading = false,
        errorMessage = '';

  CreditState copyWith({
    List<CreditMbank>? credits,
    bool? isLoading,
    String? errorMessage,
  }) {
    return CreditState(
      credits: credits ?? this.credits,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
class CreditCubit extends Cubit<CreditState> {
  final ApiService apiService = ApiService();

  CreditCubit() : super(CreditState.initial());

  Future<void> fetchCredits() async {
    emit(state.copyWith(isLoading: true, errorMessage: ''));

    try {
      final CreditMbank credit = await apiService.fetchCredits();
      emit(state.copyWith(credits: [credit], isLoading: false));
    } catch (e) {
      print("errorBloc: $e");
      emit(state.copyWith(errorMessage: 'Failed to fetch credits', isLoading: false));
    }
  }
}