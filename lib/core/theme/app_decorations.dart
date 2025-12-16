import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppDecorations {
  const AppDecorations._();

  static BoxDecoration _primaryGradient(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;

    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: isDark
            ? <Color>[
                Colors.blueGrey.shade900,
                Colors.black,
              ]
            : <Color>[
                Colors.blue.shade50,
                Colors.white,
              ],
      ),
    );
  }

  static BoxDecoration primaryCard(BuildContext context) {
    return _primaryGradient(context).copyWith(
      borderRadius: BorderRadius.circular(16.r),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.black12,
          blurRadius: 5.r,
          offset: const Offset(0, 3),
        ),
      ],
    );
  }

  static BoxDecoration primaryAppBar(BuildContext context) {
    return _primaryGradient(context);
  }
}


