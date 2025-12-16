part of 'follow_up_cubit.dart';

class FollowUpState extends Equatable {
  const FollowUpState({
    required this.isLoading,
    required this.allFollowUps,
    required this.visibleFollowUps,
    required this.searchQuery,
    required this.statusFilter,
  });

  const FollowUpState.initial()
      : isLoading = false,
        allFollowUps = const <FollowUp>[],
        visibleFollowUps = const <FollowUp>[],
        searchQuery = '',
        statusFilter = FollowUpStatusFilter.all;

  final bool isLoading;
  final List<FollowUp> allFollowUps;
  final List<FollowUp> visibleFollowUps;
  final String searchQuery;
  final FollowUpStatusFilter statusFilter;

  FollowUpState copyWith({
    bool? isLoading,
    List<FollowUp>? allFollowUps,
    List<FollowUp>? visibleFollowUps,
    String? searchQuery,
    FollowUpStatusFilter? statusFilter,
  }) {
    return FollowUpState(
      isLoading: isLoading ?? this.isLoading,
      allFollowUps: allFollowUps ?? this.allFollowUps,
      visibleFollowUps: visibleFollowUps ?? this.visibleFollowUps,
      searchQuery: searchQuery ?? this.searchQuery,
      statusFilter: statusFilter ?? this.statusFilter,
    );
  }

  FollowUpState withAppliedFilters() {
    Iterable<FollowUp> current = allFollowUps;

    current = current.where((FollowUp f) {
      switch (statusFilter) {
        case FollowUpStatusFilter.all:
          return true;
        case FollowUpStatusFilter.completed:
          return f.status == FollowUpStatus.completed;
        case FollowUpStatusFilter.scheduled:
          return f.status == FollowUpStatus.scheduled;
        case FollowUpStatusFilter.noStatus:
          return f.status == FollowUpStatus.none;
      }
    });

    final String query = searchQuery.trim().toLowerCase();
    if (query.isNotEmpty) {
      current = current.where(
        (FollowUp f) =>
            f.title.toLowerCase().contains(query) ||
            (f.customerName?.toLowerCase().contains(query) ?? false),
      );
    }

    return copyWith(
      visibleFollowUps: current.toList(growable: false),
    );
  }

  @override
  List<Object?> get props => <Object?>[
        isLoading,
        allFollowUps,
        visibleFollowUps,
        searchQuery,
        statusFilter,
      ];
}

