import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/follow_up.dart';
import '../../services/follow_up_service.dart';

part 'follow_up_state.dart';

enum FollowUpStatusFilter {
  all,
  completed,
  scheduled,
  noStatus,
}

class FollowUpCubit extends Cubit<FollowUpState> {
  FollowUpCubit(this._service) : super(const FollowUpState.initial());

  final FollowUpService _service;
  Timer? _debounceTimer;

  Future<void> loadFollowUps() async {
    emit(state.copyWith(isLoading: true));
    try {
      final List<FollowUp> all = await _service.fetchFollowUps();
      emit(
        state.copyWith(
          isLoading: false,
          allFollowUps: all,
        ).withAppliedFilters(),
      );
    } catch (_) {
      emit(state.copyWith(isLoading: false));
    }
  }

  void onSearchChanged(String query) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 300), () {
      emit(
        state.copyWith(
          searchQuery: query,
        ).withAppliedFilters(),
      );
    });
  }

  void changeStatusFilter(FollowUpStatusFilter filter) {
    emit(
      state.copyWith(
        statusFilter: filter,
      ).withAppliedFilters(),
    );
  }

  @override
  Future<void> close() {
    _debounceTimer?.cancel();
    return super.close();
  }
}

