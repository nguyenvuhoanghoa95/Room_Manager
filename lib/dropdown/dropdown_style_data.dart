part of 'dropdown_button2.dart';

/// A class to configure the theme of the button.
class ButtonStyleData {
  /// Creates a ButtonStyleData.
  const ButtonStyleData({
    this.height,
    this.width,
    this.padding,
    this.decoration,
    this.foregroundDecoration,
    this.elevation,
    this.overlayColor,
  });

  /// The height of the button
  final double? height;

  /// The width of the button
  final double? width;

  /// The inner padding of the Button
  final EdgeInsetsGeometry? padding;

  /// The decoration of the Button
  final BoxDecoration? decoration;

  /// The decoration to paint in front of the Button
  final BoxDecoration? foregroundDecoration;

  /// The elevation of the Button
  final int? elevation;

  /// Defines the ink response focus, hover, and splash colors.
  ///
  /// This default null property can be used as an alternative to
  /// [focusColor], [hoverColor], [highlightColor], and
  /// [splashColor]. If non-null, it is resolved against one of
  /// [MaterialState.focused], [MaterialState.hovered], and
  /// [MaterialState.pressed]. It's convenient to use when the parent
  /// widget can pass along its own MaterialStateProperty value for
  /// the overlay color.
  ///
  /// [MaterialState.pressed] triggers a ripple (an ink splash), per
  /// the current Material Design spec. The [overlayColor] doesn't map
  /// a state to [highlightColor] because a separate highlight is not
  /// used by the current design guidelines. See
  /// https://material.io/design/interaction/states.html#pressed
  ///
  /// If the overlay color is null or resolves to null, then [focusColor],
  /// [hoverColor], [splashColor] and their defaults are used instead.
  ///
  /// See also:
  ///
  ///  * The Material Design specification for overlay colors and how they
  ///    match a component's state:
  ///    <https://material.io/design/interaction/states.html#anatomy>.
  final MaterialStateProperty<Color?>? overlayColor;
}

/// A class to configure the theme of the button's icon.
class IconStyleData {
  /// Creates an IconStyleData.
  const IconStyleData({
    this.icon = const Icon(Icons.arrow_drop_down),
    this.iconDisabledColor,
    this.iconEnabledColor,
    this.iconSize = 24,
    this.openMenuIcon,
  });

  /// The widget to use for the drop-down button's suffix icon.
  ///
  /// Defaults to an [Icon] with the [Icons.arrow_drop_down] glyph.
  final Widget icon;

  /// The color of any [Icon] descendant of [icon] if this button is disabled,
  /// i.e. if [onChanged] is null.
  ///
  /// Defaults to [MaterialColor.shade400] of [Colors.grey] when the theme's
  /// [ThemeData.brightness] is [Brightness.light] and to
  /// [Colors.white10] when it is [Brightness.dark]
  final Color? iconDisabledColor;

  /// The color of any [Icon] descendant of [icon] if this button is enabled,
  /// i.e. if [onChanged] is defined.
  ///
  /// Defaults to [MaterialColor.shade700] of [Colors.grey] when the theme's
  /// [ThemeData.brightness] is [Brightness.light] and to
  /// [Colors.white70] when it is [Brightness.dark]
  final Color? iconEnabledColor;

  /// The size to use for the drop-down button's icon.
  ///
  /// Defaults to 24.0.
  final double iconSize;

  /// Shows different icon when monthyear.dart menu is open
  final Widget? openMenuIcon;
}

/// A class to configure the theme of the monthyear.dart menu.
class DropdownStyleData {
  /// Creates a DropdownStyleData.
  const DropdownStyleData({
    this.maxHeight,
    this.width,
    this.padding,
    this.scrollPadding,
    this.decoration,
    this.elevation = 8,
    this.direction = DropdownDirection.textDirection,
    this.offset = Offset.zero,
    this.isOverButton = false,
    this.useSafeArea = true,
    @Deprecated('Use useRootNavigator instead.') this.isFullScreen,
    this.useRootNavigator = false,
    this.scrollbarTheme,
    this.openInterval = const Interval(0.25, 0.5),
    this.dropdownBuilder,
  });

  /// The maximum height of the monthyear.dart menu
  ///
  /// The maximum height of the menu must be at least one row shorter than
  /// the height of the app's view. This ensures that a tappable area
  /// outside of the simple menu is present so the user can dismiss the menu.
  ///
  /// If this property is set above the maximum allowable height threshold
  /// mentioned above, then the menu defaults to being padded at the top
  /// and bottom of the menu by at one menu item's height.
  final double? maxHeight;

  /// The width of the monthyear.dart menu
  final double? width;

  /// The inner padding of the monthyear.dart menu
  ///
  /// The horizontal padding will be added to the button's padding as well, ensuring that
  /// the menu width and button width adapt seamlessly to the maximum width of the items.
  final EdgeInsetsGeometry? padding;

  /// The inner padding of the monthyear.dart menu including the scrollbar
  ///
  /// The horizontal padding will be added to the button's padding as well, ensuring that
  /// the menu width and button width adapt seamlessly to the maximum width of the items.
  final EdgeInsetsGeometry? scrollPadding;

  /// The decoration of the monthyear.dart menu
  final BoxDecoration? decoration;

  /// The z-coordinate at which to place the menu when open.
  ///
  /// The following elevations have defined shadows: 1, 2, 3, 4, 6, 8, 9, 12,
  /// 16, and 24. See [kElevationToShadow].
  ///
  /// Defaults to 8, the appropriate elevation for monthyear.dart buttons.
  final int elevation;

  /// The direction of the monthyear.dart menu in relation to the button.
  ///
  /// Default is [DropdownDirection.textDirection]
  final DropdownDirection direction;

  /// Changes the position of the monthyear.dart menu
  final Offset offset;

  /// Opens the monthyear.dart menu over the button instead of below it
  final bool isOverButton;

  /// Determine if the monthyear.dart menu should only display in safe areas of the screen.
  /// It is true by default, which means the monthyear.dart menu will not overlap
  /// operating system areas.
  final bool useSafeArea;

  /// Opens the monthyear.dart menu in fullscreen mode (Above AppBar & TabBar)
  ///
  /// Deprecated in favor of [useRootNavigator].
  @Deprecated('Use useRootNavigator instead.')
  final bool? isFullScreen;

  /// Determine whether to open the monthyear.dart menu using the root Navigator or not.
  /// If it's set to to true, monthyear.dart menu will be pushed above all subsequent
  /// instances of the root navigator such as AppBar/TabBar. By default, it is false.
  final bool useRootNavigator;

  /// Configures the theme of the menu's scrollbar
  final ScrollbarThemeData? scrollbarTheme;

  /// The animation curve used for opening the monthyear.dart menu (forward direction)
  final Interval openInterval;

  /// A builder to customize the monthyear.dart menu.
  ///
  /// Example:
  /// ```dart
  /// dropdownBuilder: (ctx, child) {
  ///   return ClipRRect(
  ///     clipBehavior: Clip.antiAlias,
  ///     child: BackdropFilter(
  ///       filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
  ///       child: child,
  ///     ),
  ///   );
  /// },
  /// ```
  final DropdownBuilder? dropdownBuilder;
}

/// A class to configure the theme of the monthyear.dart menu items.
class MenuItemStyleData {
  /// Creates a MenuItemStyleData.
  const MenuItemStyleData({
    this.padding,
    this.borderRadius,
    this.overlayColor,
    this.selectedMenuItemBuilder,
  });

  /// The padding applied to each menu item.
  ///
  /// The horizontal padding will be added to the button's padding as well, ensuring that
  /// the menu width and button width adapt seamlessly to the maximum width of the items.
  final EdgeInsetsGeometry? padding;

  /// The border radius of the menu item.
  final BorderRadius? borderRadius;

  /// Defines the ink response focus, hover, and splash colors.
  ///
  /// This default null property can be used as an alternative to
  /// [focusColor], [hoverColor], [highlightColor], and
  /// [splashColor]. If non-null, it is resolved against one of
  /// [MaterialState.focused], [MaterialState.hovered], and
  /// [MaterialState.pressed]. It's convenient to use when the parent
  /// widget can pass along its own MaterialStateProperty value for
  /// the overlay color.
  ///
  /// [MaterialState.pressed] triggers a ripple (an ink splash), per
  /// the current Material Design spec. The [overlayColor] doesn't map
  /// a state to [highlightColor] because a separate highlight is not
  /// used by the current design guidelines. See
  /// https://material.io/design/interaction/states.html#pressed
  ///
  /// If the overlay color is null or resolves to null, then [focusColor],
  /// [hoverColor], [splashColor] and their defaults are used instead.
  ///
  /// See also:
  ///
  ///  * The Material Design specification for overlay colors and how they
  ///    match a component's state:
  ///    <https://material.io/design/interaction/states.html#anatomy>.
  final MaterialStateProperty<Color?>? overlayColor;

  /// A builder to customize the selected menu item.
  ///
  /// If this callback is null, the selected menu item will be displayed as other [items].
  ///
  /// You should return the child from the builder wrapped with the widget that
  /// customize your item, i.e:
  /// ```dart
  /// selectedMenuItemBuilder: (ctx, child) {
  ///   return Container(
  ///     color: Colors.blue,
  ///     child: child,
  ///   );
  /// },
  /// ```
  final SelectedMenuItemBuilder? selectedMenuItemBuilder;
}

/// A class to configure searchable dropdowns.
class DropdownSearchData<T> {
  /// Creates a DropdownSearchData.
  const DropdownSearchData({
    this.searchController,
    this.searchBarWidget,
    this.searchBarWidgetHeight,
    this.noResultsWidget,
    this.searchMatchFn,
  }) : assert(
          (searchBarWidget == null) == (searchBarWidgetHeight == null),
          'searchBarWidgetHeight should not be null when using searchBarWidget\n'
          'This is necessary to properly determine menu limits and scroll offset',
        );

  /// The TextEditingController used for searchable dropdowns. If this is null,
  /// then it'll perform as a normal monthyear.dart without searching feature.
  final TextEditingController? searchController;

  /// The widget to use for searchable dropdowns, such as search bar.
  /// It will be shown at the top of the monthyear.dart menu.
  final Widget? searchBarWidget;

  /// The height of the searchBarWidget if used.
  final double? searchBarWidgetHeight;

  /// The widget to show when the search results are empty.
  final Widget? noResultsWidget;

  /// The match function used for searchable dropdowns. If this is null,
  /// then _defaultSearchMatchFn will be used.
  ///
  /// ```dart
  /// _defaultSearchMatchFn = (item, searchValue) =>
  ///   item.value.toString().toLowerCase().contains(searchValue.toLowerCase());
  /// ```
  final SearchMatchFn<T>? searchMatchFn;
}
