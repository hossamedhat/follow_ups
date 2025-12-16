
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../cubit/follow_up/follow_up_cubit.dart';
import 'filter_option_tile.dart';

class FilterBottomSheet extends StatelessWidget {
  const FilterBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text(
                  'Filter by status',
                  style:
                  TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
                IconButton.filledTonal(

                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.close_rounded),
                  tooltip: 'Close Sheet',
                  iconSize: 16.sp,

                ),

              ],
            ),
            const SizedBox(height: 8),
            FilterOptionTile(
              title: 'All',
              selected:
              context.read<FollowUpCubit>().state.statusFilter ==
                  FollowUpStatusFilter.all,
              onTap: () {
                context.read<FollowUpCubit>().changeStatusFilter(
                  FollowUpStatusFilter.all,
                );
                Navigator.of(context).pop();
              },
            ),
            FilterOptionTile(
              title: 'Completed',
              selected:
              context.read<FollowUpCubit>().state.statusFilter ==
                  FollowUpStatusFilter.completed,
              onTap: () {
                context.read<FollowUpCubit>().changeStatusFilter(
                  FollowUpStatusFilter.completed,
                );
                Navigator.of(context).pop();
              },
            ),
            FilterOptionTile(
              title: 'Scheduled',
              selected:
              context.read<FollowUpCubit>().state.statusFilter ==
                  FollowUpStatusFilter.scheduled,
              onTap: () {
                context.read<FollowUpCubit>().changeStatusFilter(
                  FollowUpStatusFilter.scheduled,
                );
                Navigator.of(context).pop();
              },
            ),
            FilterOptionTile(
              title: 'No Status',
              selected:
              context.read<FollowUpCubit>().state.statusFilter ==
                  FollowUpStatusFilter.noStatus,
              onTap: () {
                context.read<FollowUpCubit>().changeStatusFilter(
                  FollowUpStatusFilter.noStatus,
                );
                Navigator.of(context).pop();
              },
            ),
             SizedBox(height: 12.h),
          ],
        ),
      ),
    );
  }
}

