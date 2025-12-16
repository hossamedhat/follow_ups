import 'package:dotted_dashed_line/dotted_dashed_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/theme/app_decorations.dart';
import '../models/follow_up.dart';

class FollowUpCard extends StatelessWidget {
  const FollowUpCard({
    super.key,
    required this.followUp,
  });

  final FollowUp followUp;

  Color _statusColor(BuildContext context) {
    switch (followUp.status) {
      case FollowUpStatus.completed:
        return Colors.green.shade600;
      case FollowUpStatus.scheduled:
        return Colors.orange.shade600;
      case FollowUpStatus.none:
        return Theme.of(context).colorScheme.outline;
    }
  }

  String _statusLabel() {
    switch (followUp.status) {
      case FollowUpStatus.completed:
        return 'Completed';
      case FollowUpStatus.scheduled:
        return 'Scheduled';
      case FollowUpStatus.none:
        return 'No Status';
    }
  }

  IconData _typeIcon() {
    switch (followUp.type) {
      case FollowUpType.call:
        return Icons.call_rounded;
      case FollowUpType.meeting:
        return Icons.calendar_today_rounded;
      case FollowUpType.visit:
        return Icons.place_rounded;
    }
  }

  String _typeLabel() {
    switch (followUp.type) {
      case FollowUpType.call:
        return 'Call';
      case FollowUpType.meeting:
        return 'Meeting';
      case FollowUpType.visit:
        return 'Visit';
    }
  }

  bool _containsHtml(String text) {
    final RegExp htmlTagPattern = RegExp(r'<[^>]+>');
    return htmlTagPattern.hasMatch(text);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Color mainIconColor =
        theme.iconTheme.color ?? theme.colorScheme.primary;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w,vertical: 10.h),
      margin: EdgeInsets.symmetric(vertical: 8.h),
      decoration: AppDecorations.primaryCard(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 10.w,
                  vertical: 6.h,
                ),
                decoration: BoxDecoration(
                  color: mainIconColor.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  children: <Widget>[
                    Icon(
                      _typeIcon(),
                      size: 16.sp,
                      color: mainIconColor,
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      _typeLabel(),
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: mainIconColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Text(
                followUp.id,
                style: theme.textTheme.labelMedium?.copyWith(
                  color: theme.colorScheme.outline,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Text(
            followUp.title,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          if (followUp.customerName != null) ...<Widget>[
            SizedBox(height: 4.h),
            Text(
              followUp.customerName!,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
          if (followUp.description != null &&
              followUp.description!.isNotEmpty) ...<Widget>[
            SizedBox(height: 8.h),
            _containsHtml(followUp.description!)
                ? Html(
                    data: followUp.description!,
                    style: <String, Style>{
                      'body': Style(
                        margin: Margins.zero,
                        padding: HtmlPaddings.zero,
                        fontSize: FontSize(
                          theme.textTheme.bodyMedium?.fontSize ?? 14,
                        ),
                        color: theme.colorScheme.onSurface.withValues(
                          alpha: 0.75,
                        ),
                      ),
                      'b': Style(
                        fontWeight: FontWeight.bold,
                      ),
                      'p': Style(
                        margin: Margins.only(bottom: 4),
                      ),
                    },
                  )
                : Text(
                    followUp.description!,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.75),
                    ),
                  ),
          ],
          SizedBox(height: 12.h),
          SizedBox(
            height: 15.h,
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Positioned(
                  left: -10.w,
                  child: CircleAvatar(
                    radius: 10,
                    backgroundColor: mainIconColor.withValues(alpha: 0.8),
                  ),
                ),
                DottedDashedLine(
                  height: 1,
                  width: double.infinity,
                  dashColor:  mainIconColor.withValues(alpha: 0.5),
                  axis: Axis.horizontal,
                ),
                Positioned(
                  right: -10.w,
                  child: CircleAvatar(
                    radius: 10,
                    backgroundColor: mainIconColor.withValues(alpha: 0.8)
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 8.h),
            padding: EdgeInsets.symmetric(
              horizontal: 10.w,
              vertical: 6.h,
            ),
            decoration: BoxDecoration(
              color: _statusColor(context).withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(999),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  width: 8.w,
                  height: 8.w,
                  decoration: BoxDecoration(
                    color: _statusColor(context),
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: 6.w),
                Text(
                  _statusLabel(),
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: _statusColor(context),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


