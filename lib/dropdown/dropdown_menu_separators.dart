part of 'dropdown_button2.dart';

/// Represents a separator widget in a monthyear.dart menu created by a [DropdownButton2].
///
/// The [child] property must be set.
class DropdownSeparator<T> extends DropdownItem<T> {
  /// Creates a monthyear.dart separator.
  const DropdownSeparator({
    required super.child,
    super.height,
    super.enabled = false,
    super.key,
  });
}
