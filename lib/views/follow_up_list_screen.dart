import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:follow_ups/widgets/filter_bottom_sheet.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../core/di/service_locator.dart';
import '../core/theme/app_decorations.dart';
import '../cubit/follow_up/follow_up_cubit.dart';
import '../cubit/theme/theme_cubit.dart';
import '../widgets/empty_state.dart';
import '../widgets/follow_up_card.dart';

class FollowUpListScreen extends StatelessWidget {
  const FollowUpListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FollowUpCubit>(
      create: (_) => getIt<FollowUpCubit>()..loadFollowUps(),
      child: const _FollowUpListView(),
    );
  }
}

class _FollowUpListView extends StatelessWidget {
  const _FollowUpListView();

  String _filterLabel(FollowUpStatusFilter filter) {
    switch (filter) {
      case FollowUpStatusFilter.all:
        return 'All';
      case FollowUpStatusFilter.completed:
        return 'Completed';
      case FollowUpStatusFilter.scheduled:
        return 'Scheduled';
      case FollowUpStatusFilter.noStatus:
        return 'No Status';
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final FollowUpCubit cubit = context.watch<FollowUpCubit>();
    final FollowUpState state = cubit.state;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Follow Ups'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: AppDecorations.primaryAppBar(context),
        ),
        actions: <Widget>[
          IconButton(
            tooltip: 'Toggle theme',
            icon: Icon(
              theme.brightness == Brightness.dark
                  ? Icons.dark_mode_rounded
                  : Icons.light_mode_rounded,
            ),
            onPressed: () => context.read<ThemeCubit>().toggleTheme(),
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final bool isWide = constraints.maxWidth > 600;

          return GestureDetector(
            onTap: () =>  FocusManager.instance.primaryFocus?.unfocus(),
            onVerticalDragStart: (details) =>  FocusManager.instance.primaryFocus?.unfocus(),
            onVerticalDragDown: (details) =>  FocusManager.instance.primaryFocus?.unfocus(),
            onVerticalDragEnd: (details) =>  FocusManager.instance.primaryFocus?.unfocus(),
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: TextField(
                          onChanged: (String value) => context
                              .read<FollowUpCubit>()
                              .onSearchChanged(value),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsetsDirectional.symmetric(horizontal: 10.w),
                            prefixIcon: const Icon(FontAwesomeIcons.searchengin),
                            hintText: 'Search by title or customer ...',
                            hintStyle: TextStyle(
                              fontSize: 12.sp,

                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.r),
                            ),
                            isDense: true,
                          ),
                        ),
                      ),
                      SizedBox(width: 5.w),
                      IconButton.filledTonal(

                        onPressed: () {
                          _showFilterBottomSheet(context);
                        },
                        icon: const Icon(Icons.filter_list_rounded),
                        tooltip: 'Filter',

                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(FontAwesomeIcons.codeMerge,color: theme.colorScheme.outline,size: 16.sp,),
                        SizedBox(width: 5.w),
                        Text(
                          'Status: ${_filterLabel(state.statusFilter)}',
                          style: theme.textTheme.labelMedium?.copyWith(
                            color: theme.colorScheme.outline,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Expanded(
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 200),
                      child: state.isLoading
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : state.visibleFollowUps.isEmpty
                              ? EmptyState(
                                  message: state.searchQuery.isEmpty
                                      ? 'No follow-ups available.'
                                      : 'No follow-ups match your search.',
                                )
                              : isWide
                                  ? GridView.builder(
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 16,
                                        mainAxisSpacing: 16,
                                        // Make cards taller on wide screens to avoid overflow
                                        childAspectRatio: 0.9,
                                      ),
                                      itemCount: state.visibleFollowUps.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return FollowUpCard(
                                          followUp: state.visibleFollowUps[index],
                                        );
                                      },
                                    )
                                  : ListView.builder(
                                      itemCount: state.visibleFollowUps.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return FollowUpCard(
                                          followUp: state.visibleFollowUps[index],
                                        );
                                      },
                                    ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _showFilterBottomSheet(
    BuildContext parentContext,
  ) {
    showModalBottomSheet<void>(
      context: parentContext,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      builder: (BuildContext sheetContext) {
        // Reuse the same FollowUpCubit instance inside the bottom sheet.
        return BlocProvider.value(
          value: parentContext.read<FollowUpCubit>(),
          child: const FilterBottomSheet(),
        );
      },
    );
  }
}






