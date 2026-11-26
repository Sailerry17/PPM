import 'package:flutter/widgets.dart';

/// Kelas ukuran jendela berdasarkan lebar layar (Material 3 window size classes).
///
/// * compact  : lebar < 600
/// * medium   : 600 <= lebar < 840
/// * expanded : lebar >= 840
enum WindowSize {
  compact,
  medium,
  expanded;

  static const double mediumBreakpoint = 600;
  static const double expandedBreakpoint = 840;

  static WindowSize fromWidth(double width) {
    if (width < mediumBreakpoint) return WindowSize.compact;
    if (width < expandedBreakpoint) return WindowSize.medium;
    return WindowSize.expanded;
  }

  /// Memakai [MediaQuery.sizeOf] agar widget hanya rebuild saat ukuran berubah.
  static WindowSize of(BuildContext context) =>
      fromWidth(MediaQuery.sizeOf(context).width);

  bool get isCompact => this == WindowSize.compact;
}
