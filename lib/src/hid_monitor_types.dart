/// Base class for all mouse events.
///
/// Contains the current mouse position coordinates.
/// All mouse events (button clicks, movement, scroll) extend this class.
///
/// Example:
/// ```dart
/// backend.addMouseListener((MouseEvent event) {
///   print('Mouse at: ${event.x}, ${event.y}');
/// });
/// ```
class MouseEvent {
  /// Creates a new mouse event with the specified coordinates.
  ///
  /// The [x] and [y] parameters represent the mouse position
  /// at the time of the event.
  MouseEvent({required this.x, required this.y});

  /// The X coordinate of the mouse position.
  double x;

  /// The Y coordinate of the mouse position.
  double y;
}

/// Enum representing the type of mouse button event.
///
/// These values indicate which mouse button was pressed or released
/// and the state change (down or up).
enum MouseButtonEventType {
  /// Left mouse button was released.
  leftButtonUp,

  /// Left mouse button was pressed down.
  leftButtonDown,

  /// Right mouse button was released.
  rightButtonUp,

  /// Right mouse button was pressed down.
  rightButtonDown,
}

/// Event representing a mouse button press or release.
///
/// This event is triggered when any mouse button is pressed down
/// or released. Use the [type] property to determine which button
/// and whether it was a press or release.
///
/// Example:
/// ```dart
/// backend.addMouseListener((MouseEvent event) {
///   if (event is MouseButtonEvent) {
///     switch (event.type) {
///       case MouseButtonEventType.leftButtonDown:
///         print('Left button pressed at ${event.x}, ${event.y}');
///       case MouseButtonEventType.leftButtonUp:
///         print('Left button released');
///       case MouseButtonEventType.rightButtonDown:
///         print('Right button pressed');
///       case MouseButtonEventType.rightButtonUp:
///         print('Right button released');
///     }
///   }
/// });
/// ```
class MouseButtonEvent extends MouseEvent {
  /// Creates a new mouse button event.
  ///
  /// The [type] parameter indicates which button and its state.
  MouseButtonEvent({required super.x, required super.y, required this.type});

  /// The type of mouse button event.
  MouseButtonEventType type;
}

/// Event representing mouse movement.
///
/// This event is triggered whenever the mouse position changes.
/// The [x] and [y] coordinates from the parent class represent
/// the new mouse position.
///
/// Example:
/// ```dart
/// backend.addMouseListener((MouseEvent event) {
///   if (event is MouseMoveEvent) {
///     print('Mouse moved to: ${event.x}, ${event.y}');
///   }
/// });
/// ```
class MouseMoveEvent extends MouseEvent {
  /// Creates a new mouse move event.
  MouseMoveEvent({required super.x, required super.y});
}

/// Event representing mouse scroll wheel movement.
///
/// This event is triggered when the user rotates the scroll wheel.
/// The [wheelDelta] indicates the amount and direction of scrolling.
///
/// Example:
/// ```dart
/// backend.addMouseListener((MouseEvent event) {
///   if (event is MouseWheelEvent) {
///     if (event.isHorizontal) {
///       print('Horizontal scroll: ${event.wheelDelta}');
///     } else {
///       print('Vertical scroll: ${event.wheelDelta}');
///     }
///   }
/// });
/// ```
class MouseWheelEvent extends MouseEvent {
  /// Creates a new mouse wheel event.
  ///
  /// The [wheelDelta] indicates the scroll amount (positive for
  /// up/right, negative for down/left).
  /// The [isHorizontal] parameter indicates whether this is a
  /// horizontal scroll (true) or vertical scroll (false).
  MouseWheelEvent(
      {required super.x,
      required super.y,
      required this.wheelDelta,
      required this.isHorizontal});

  /// The amount of wheel rotation.
  ///
  /// Positive values indicate scrolling up (or right for horizontal),
  /// negative values indicate scrolling down (or left for horizontal).
  int wheelDelta;

  /// Whether this is a horizontal scroll event.
  ///
  /// If `true`, the scroll is horizontal (left/right).
  /// If `false`, the scroll is vertical (up/down).
  bool isHorizontal;
}
