part of 'dropdown_button2.dart';

/// The direction of the monthyear.dart menu in relation to the button.
///
/// Default is [DropdownDirection.textDirection]
enum DropdownDirection {
  /// The direction of the monthyear.dart menu in relation to the button follows
  /// text direction from the closest [Directionality] ancestor widget in the tree.
  textDirection,

  /// The direction of the monthyear.dart menu is to the right of the button.
  right,

  /// The direction of the monthyear.dart menu is to the left of the button.
  left,

  /// Dropdown menu is centered on the screen.
  center,
}
