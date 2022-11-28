// // Copyright 2014 The Flutter Authors. All rights reserved.
// // Use of this source code is governed by a BSD-style license that can be
// // found in the LICENSE file.

// import 'dart:async';

// import 'package:flutter/foundation.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:flutter/services.dart';


// /// Signature for when a tooltip is triggered.
// typedef TooltipTriggeredCallback = void Function();

// class KrsTooltip extends StatefulWidget {
//   /// Creates a tooltip.
//   ///
//   /// By default, tooltips should adhere to the
//   /// [Material specification](https://material.io/design/components/tooltips.html#spec).
//   /// If the optional constructor parameters are not defined, the values
//   /// provided by [TooltipTheme.of] will be used if a [TooltipTheme] is present
//   /// or specified in [ThemeData].
//   ///
//   /// All parameters that are defined in the constructor will
//   /// override the default values _and_ the values in [TooltipTheme.of].
//   ///
//   /// Only one of [message] and [richMessage] may be non-null.
//   const KrsTooltip({
//     super.key,
//     this.message,
//     this.richMessage,
//     this.height,
//     this.padding,
//     this.margin,
//     this.verticalOffset,
//     this.preferBelow,
//     this.excludeFromSemantics,
//     this.decoration,
//     this.textStyle,
//     this.textAlign,
//     this.waitDuration,
//     this.showDuration,
//     this.enableFeedback,
//     this.onTriggered,
//     this.child,
//   }) :  assert((message == null) != (richMessage == null), 'Either `message` or `richMessage` must be specified'),
//         assert(
//           richMessage == null || textStyle == null,
//           'If `richMessage` is specified, `textStyle` will have no effect. '
//           'If you wish to provide a `textStyle` for a rich tooltip, add the '
//           '`textStyle` directly to the `richMessage` InlineSpan.',
//         );

//   /// The text to display in the tooltip.
//   ///
//   /// Only one of [message] and [richMessage] may be non-null.
//   final String? message;

//   /// The rich text to display in the tooltip.
//   ///
//   /// Only one of [message] and [richMessage] may be non-null.
//   final InlineSpan? richMessage;

//   /// The height of the tooltip's [child].
//   ///
//   /// If the [child] is null, then this is the tooltip's intrinsic height.
//   final double? height;

//   /// The amount of space by which to inset the tooltip's [child].
//   ///
//   /// On mobile, defaults to 16.0 logical pixels horizontally and 4.0 vertically.
//   /// On desktop, defaults to 8.0 logical pixels horizontally and 4.0 vertically.
//   final EdgeInsetsGeometry? padding;

//   /// The empty space that surrounds the tooltip.
//   ///
//   /// Defines the tooltip's outer [Container.margin]. By default, a
//   /// long tooltip will span the width of its window. If long enough,
//   /// a tooltip might also span the window's height. This property allows
//   /// one to define how much space the tooltip must be inset from the edges
//   /// of their display window.
//   ///
//   /// If this property is null, then [TooltipThemeData.margin] is used.
//   /// If [TooltipThemeData.margin] is also null, the default margin is
//   /// 0.0 logical pixels on all sides.
//   final EdgeInsetsGeometry? margin;

//   /// The vertical gap between the widget and the displayed tooltip.
//   ///
//   /// When [preferBelow] is set to true and tooltips have sufficient space to
//   /// display themselves, this property defines how much vertical space
//   /// tooltips will position themselves under their corresponding widgets.
//   /// Otherwise, tooltips will position themselves above their corresponding
//   /// widgets with the given offset.
//   final double? verticalOffset;

//   /// Whether the tooltip defaults to being displayed below the widget.
//   ///
//   /// Defaults to true. If there is insufficient space to display the tooltip in
//   /// the preferred direction, the tooltip will be displayed in the opposite
//   /// direction.
//   final bool? preferBelow;

//   /// Whether the tooltip's [message] or [richMessage] should be excluded from
//   /// the semantics tree.
//   ///
//   /// Defaults to false. A tooltip will add a [Semantics] label that is set to
//   /// [KrsTooltip.message] if non-null, or the plain text value of
//   /// [KrsTooltip.richMessage] otherwise. Set this property to true if the app is
//   /// going to provide its own custom semantics label.
//   final bool? excludeFromSemantics;

//   /// The widget below this widget in the tree.
//   ///
//   /// {@macro flutter.widgets.ProxyWidget.child}
//   final Widget? child;

//   /// Specifies the tooltip's shape and background color.
//   ///
//   /// The tooltip shape defaults to a rounded rectangle with a border radius of
//   /// 4.0. Tooltips will also default to an opacity of 90% and with the color
//   /// [Colors.grey]\[700\] if [ThemeData.brightness] is [Brightness.dark], and
//   /// [Colors.white] if it is [Brightness.light].
//   final Decoration? decoration;

//   /// The style to use for the message of the tooltip.
//   ///
//   /// If null, the message's [TextStyle] will be determined based on
//   /// [ThemeData]. If [ThemeData.brightness] is set to [Brightness.dark],
//   /// [TextTheme.bodyText2] of [ThemeData.textTheme] will be used with
//   /// [Colors.white]. Otherwise, if [ThemeData.brightness] is set to
//   /// [Brightness.light], [TextTheme.bodyText2] of [ThemeData.textTheme] will be
//   /// used with [Colors.black].
//   final TextStyle? textStyle;

//   /// How the message of the tooltip is aligned horizontally.
//   ///
//   /// If this property is null, then [TooltipThemeData.textAlign] is used.
//   /// If [TooltipThemeData.textAlign] is also null, the default value is
//   /// [TextAlign.start].
//   final TextAlign? textAlign;

//   /// The length of time that a pointer must hover over a tooltip's widget
//   /// before the tooltip will be shown.
//   ///
//   /// Defaults to 0 milliseconds (tooltips are shown immediately upon hover).
//   final Duration? waitDuration;

//   /// The length of time that the tooltip will be shown after a long press is
//   /// exits the widget.
//   ///
//   /// Defaults to 1.5 seconds for long press and tap released or 0.1 seconds
//   /// for mouse pointer exits the widget.
//   final Duration? showDuration;

//   /// Whether the tooltip should provide acoustic and/or haptic feedback.
//   ///
//   /// For example, on Android a tap will produce a clicking sound and a
//   /// long-press will produce a short vibration, when feedback is enabled.
//   ///
//   /// When null, the default value is true.
//   ///
//   /// See also:
//   ///
//   ///  * [Feedback], for providing platform-specific feedback to certain actions.
//   final bool? enableFeedback;

//   /// Called when the Tooltip is triggered.
//   final TooltipTriggeredCallback? onTriggered;

//   static final List<KrsTooltipState> _openedTooltips = <KrsTooltipState>[];

//   // Causes any current tooltips to be concealed. Only called for mouse hover enter
//   // detections. Won't conceal the supplied tooltip.
//   static void _concealOtherTooltips(KrsTooltipState current) {
//     if (_openedTooltips.isNotEmpty) {
//       // Avoid concurrent modification.
//       final List<KrsTooltipState> openedTooltips = _openedTooltips.toList();
//       for (final KrsTooltipState state in openedTooltips) {
//         if (state == current) {
//           continue;
//         }
//         state._concealTooltip();
//       }
//     }
//   }

//   // Causes the most recently concealed tooltip to be revealed. Only called for mouse
//   // hover exit detections.
//   static void _revealLastTooltip() {
//     if (_openedTooltips.isNotEmpty) {
//       _openedTooltips.last._revealTooltip();
//     }
//   }

//   /// Dismiss all of the tooltips that are currently shown on the screen.
//   ///
//   /// This method returns true if it successfully dismisses the tooltips. It
//   /// returns false if there is no tooltip shown on the screen.
//   static bool dismissAllToolTips() {
//     if (_openedTooltips.isNotEmpty) {
//       // Avoid concurrent modification.
//       final List<KrsTooltipState> openedTooltips = _openedTooltips.toList();
//       for (final KrsTooltipState state in openedTooltips) {
//         state._dismissTooltip(immediately: true);
//       }
//       return true;
//     }
//     return false;
//   }

//   @override
//   State<KrsTooltip> createState() => KrsTooltipState();

//   @override
//   void debugFillProperties(DiagnosticPropertiesBuilder properties) {
//     super.debugFillProperties(properties);
//     properties.add(StringProperty(
//       'message',
//       message,
//       showName: message == null,
//       defaultValue: message == null ? null : kNoDefaultValue,
//     ));
//     properties.add(StringProperty(
//       'richMessage',
//       richMessage?.toPlainText(),
//       showName: richMessage == null,
//       defaultValue: richMessage == null ? null : kNoDefaultValue,
//     ));
//     properties.add(DoubleProperty('height', height, defaultValue: null));
//     properties.add(DiagnosticsProperty<EdgeInsetsGeometry>('padding', padding, defaultValue: null));
//     properties.add(DiagnosticsProperty<EdgeInsetsGeometry>('margin', margin, defaultValue: null));
//     properties.add(DoubleProperty('vertical offset', verticalOffset, defaultValue: null));
//     properties.add(FlagProperty('position', value: preferBelow, ifTrue: 'below', ifFalse: 'above', showName: true));
//     properties.add(FlagProperty('semantics', value: excludeFromSemantics, ifTrue: 'excluded', showName: true));
//     properties.add(DiagnosticsProperty<Duration>('wait duration', waitDuration, defaultValue: null));
//     properties.add(DiagnosticsProperty<Duration>('show duration', showDuration, defaultValue: null));
//     properties.add(FlagProperty('enableFeedback', value: enableFeedback, ifTrue: 'true', showName: true));
//     properties.add(DiagnosticsProperty<TextAlign>('textAlign', textAlign, defaultValue: null));
//   }
// }

// /// Contains the state for a [KrsTooltip].
// ///
// /// This class can be used to programmatically show the Tooltip, see the
// /// [ensureTooltipVisible] method.
// class KrsTooltipState extends State<KrsTooltip> with SingleTickerProviderStateMixin {
//   static const double _defaultVerticalOffset = 24.0;
//   static const bool _defaultPreferBelow = true;
//   static const EdgeInsetsGeometry _defaultMargin = EdgeInsets.zero;
//   static const Duration _fadeInDuration = Duration(milliseconds: 150);
//   static const Duration _fadeOutDuration = Duration(milliseconds: 75);
//   static const Duration _defaultShowDuration = Duration(milliseconds: 1500);
//   static const Duration _defaultHoverShowDuration = Duration(milliseconds: 100);
//   static const Duration _defaultWaitDuration = Duration.zero;
//   static const bool _defaultExcludeFromSemantics = false;
//   static const bool _defaultEnableFeedback = true;
//   static const TextAlign _defaultTextAlign = TextAlign.start;

//   late double _height;
//   late EdgeInsetsGeometry _padding;
//   late EdgeInsetsGeometry _margin;
//   late Decoration _decoration;
//   late TextStyle _textStyle;
//   late TextAlign _textAlign;
//   late double _verticalOffset;
//   late bool _preferBelow;
//   late bool _excludeFromSemantics;
//   late AnimationController _controller;
//   OverlayEntry? _entry;
//   Timer? _dismissTimer;
//   Timer? _showTimer;
//   late Duration _showDuration;
//   late Duration _hoverShowDuration;
//   late Duration _waitDuration;
//   late bool _mouseIsConnected;
//   bool _pressActivated = false;
//   late bool _enableFeedback;
//   late bool _isConcealed;
//   late bool _forceRemoval;
//   late bool _visible;

//   /// The plain text message for this tooltip.
//   ///
//   /// This value will either come from [widget.message] or [widget.richMessage].
//   String get _tooltipMessage => widget.message ?? widget.richMessage!.toPlainText();

//   @override
//   void initState() {
//     super.initState();
//     _isConcealed = false;
//     _forceRemoval = false;
//     _mouseIsConnected = RendererBinding.instance.mouseTracker.mouseIsConnected;
//     _controller = AnimationController(
//       duration: _fadeInDuration,
//       reverseDuration: _fadeOutDuration,
//       vsync: this,
//     )
//       ..addStatusListener(_handleStatusChanged);
//   }

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     _visible = TooltipVisibility.of(context);
//   }

//   // https://material.io/components/tooltips#specs
//   double _getDefaultTooltipHeight() {
//     final ThemeData theme = Theme.of(context);
//     switch (theme.platform) {
//       case TargetPlatform.macOS:
//       case TargetPlatform.linux:
//       case TargetPlatform.windows:
//         return 24.0;
//       case TargetPlatform.android:
//       case TargetPlatform.fuchsia:
//       case TargetPlatform.iOS:
//         return 32.0;
//     }
//   }

//   EdgeInsets _getDefaultPadding() {
//     final ThemeData theme = Theme.of(context);
//     switch (theme.platform) {
//       case TargetPlatform.macOS:
//       case TargetPlatform.linux:
//       case TargetPlatform.windows:
//         return const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0);
//       case TargetPlatform.android:
//       case TargetPlatform.fuchsia:
//       case TargetPlatform.iOS:
//         return const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0);
//     }
//   }

//   double _getDefaultFontSize() {
//     final ThemeData theme = Theme.of(context);
//     switch (theme.platform) {
//       case TargetPlatform.macOS:
//       case TargetPlatform.linux:
//       case TargetPlatform.windows:
//         return 12.0;
//       case TargetPlatform.android:
//       case TargetPlatform.fuchsia:
//       case TargetPlatform.iOS:
//         return 14.0;
//     }
//   }

//   void _handleStatusChanged(AnimationStatus status) {
//     // If this tip is concealed, don't remove it, even if it is dismissed, so that we can
//     // reveal it later, unless it has explicitly been hidden with _dismissTooltip.
//     if (status == AnimationStatus.dismissed && (_forceRemoval || !_isConcealed)) {
//       _removeEntry();
//     }
//   }

//   void _dismissTooltip({ bool immediately = false }) {
//     _showTimer?.cancel();
//     _showTimer = null;
//     if (immediately) {
//       _removeEntry();
//       return;
//     }
//     // So it will be removed when it's done reversing, regardless of whether it is
//     // still concealed or not.
//     _forceRemoval = true;
//     if (_pressActivated) {
//       _dismissTimer ??= Timer(_showDuration, _controller.reverse);
//     } else {
//       _dismissTimer ??= Timer(_hoverShowDuration, _controller.reverse);
//     }
//     _pressActivated = false;
//   }

//   void _showTooltip({ bool immediately = false }) {
//     _dismissTimer?.cancel();
//     _dismissTimer = null;
//     if (immediately) {
//       ensureTooltipVisible();
//       return;
//     }
//     _showTimer ??= Timer(_waitDuration, ensureTooltipVisible);
//   }

//   void _concealTooltip() {
//     if (_isConcealed || _forceRemoval) {
//       // Already concealed, or it's being removed.
//       return;
//     }
//     _isConcealed = true;
//     _dismissTimer?.cancel();
//     _dismissTimer = null;
//     _showTimer?.cancel();
//     _showTimer = null;
//     if (_entry != null) {
//       _entry!.remove();
//     }
//     _controller.reverse();
//   }

//   void _revealTooltip() {
//     if (!_isConcealed) {
//       // Already uncovered.
//       return;
//     }
//     _isConcealed = false;
//     _dismissTimer?.cancel();
//     _dismissTimer = null;
//     _showTimer?.cancel();
//     _showTimer = null;
//     if (!_entry!.mounted) {
//       final OverlayState overlayState = Overlay.of(
//         context,
//         debugRequiredFor: widget,
//       )!;
//       overlayState.insert(_entry!);
//     }
//     SemanticsService.tooltip(_tooltipMessage);
//     _controller.forward();
//   }

//   /// Shows the tooltip if it is not already visible.
//   ///
//   /// Returns `false` when the tooltip shouldn't be shown or when the tooltip
//   /// was already visible.
//   bool ensureTooltipVisible() {
//     if (!_visible || !mounted) {
//       return false;
//     }
//     _showTimer?.cancel();
//     _showTimer = null;
//     _forceRemoval = false;
//     if (_isConcealed) {
//       if (_mouseIsConnected) {
//         KrsTooltip._concealOtherTooltips(this);
//       }
//       _revealTooltip();
//       return true;
//     }
//     if (_entry != null) {
//       // Stop trying to hide, if we were.
//       _dismissTimer?.cancel();
//       _dismissTimer = null;
//       _controller.forward();
//       return false; // Already visible.
//     }
//     _createNewEntry();
//     _controller.forward();
//     return true;
//   }

//   static final Set<KrsTooltipState> _mouseIn = <KrsTooltipState>{};

//   void _handleMouseEnter() {
//     if (mounted) {
//       _showTooltip();
//     }
//   }

//   void _handleMouseExit({bool immediately = false}) {
//     if (mounted) {
//       // If the tip is currently covered, we can just remove it without waiting.
//       _dismissTooltip(immediately: _isConcealed || immediately);
//     }
//   }

//   void _createNewEntry() {
//     final OverlayState overlayState = Overlay.of(
//       context,
//       debugRequiredFor: widget,
//     )!;

//     final RenderBox box = context.findRenderObject()! as RenderBox;
//     final Offset target = box.localToGlobal(
//       box.size.center(Offset.zero),
//       ancestor: overlayState.context.findRenderObject(),
//     );

//     // We create this widget outside of the overlay entry's builder to prevent
//     // updated values from happening to leak into the overlay when the overlay
//     // rebuilds.
//     final Widget overlay = Directionality(
//       textDirection: Directionality.of(context),
//       child: _TooltipOverlay(
//         richMessage: widget.richMessage ?? TextSpan(text: widget.message),
//         height: _height,
//         padding: _padding,
//         margin: _margin,
//         onEnter: _mouseIsConnected ? (_) => _handleMouseEnter() : null,
//         onExit: _mouseIsConnected ? (_) => _handleMouseExit() : null,
//         decoration: _decoration,
//         textStyle: _textStyle,
//         textAlign: _textAlign,
//         animation: CurvedAnimation(
//           parent: _controller,
//           curve: Curves.fastOutSlowIn,
//         ),
//         target: target,
//         verticalOffset: _verticalOffset,
//         preferBelow: _preferBelow,
//       ),
//     );
//     _entry = OverlayEntry(builder: (BuildContext context) => overlay);
//     _isConcealed = false;
//     overlayState.insert(_entry!);
//     SemanticsService.tooltip(_tooltipMessage);
//     if (_mouseIsConnected) {
//       // Hovered tooltips shouldn't show more than one at once. For example, a chip with
//       // a delete icon shouldn't show both the delete icon tooltip and the chip tooltip
//       // at the same time.
//       KrsTooltip._concealOtherTooltips(this);
//     }
//     assert(!KrsTooltip._openedTooltips.contains(this));
//     KrsTooltip._openedTooltips.add(this);
//   }

//   void _removeEntry() {
//     KrsTooltip._openedTooltips.remove(this);
//     _mouseIn.remove(this);
//     _dismissTimer?.cancel();
//     _dismissTimer = null;
//     _showTimer?.cancel();
//     _showTimer = null;
//     if (!_isConcealed) {
//       _entry?.remove();
//     }
//     _isConcealed = false;
//     _entry = null;
//     if (_mouseIsConnected) {
//       KrsTooltip._revealLastTooltip();
//     }
//   }

//   @override
//   void deactivate() {
//     if (_entry != null) {
//       _dismissTooltip(immediately: true);
//     }
//     _showTimer?.cancel();
//     super.deactivate();
//   }

//   @override
//   void dispose() {
//     _removeEntry();
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // If message is empty then no need to create a tooltip overlay to show
//     // the empty black container so just return the wrapped child as is or
//     // empty container if child is not specified.
//     if (_tooltipMessage.isEmpty) {
//       return widget.child ?? const SizedBox();
//     }
//     assert(Overlay.of(context, debugRequiredFor: widget) != null);
//     final ThemeData theme = Theme.of(context);
//     final TooltipThemeData tooltipTheme = TooltipTheme.of(context);
//     final TextStyle defaultTextStyle;
//     final BoxDecoration defaultDecoration;
//     if (theme.brightness == Brightness.dark) {
//       defaultTextStyle = theme.textTheme.bodyText2!.copyWith(
//         color: Colors.black,
//         fontSize: _getDefaultFontSize(),
//       );
//       defaultDecoration = BoxDecoration(
//         color: Colors.white.withOpacity(0.9),
//         borderRadius: const BorderRadius.all(Radius.circular(4)),
//       );
//     } else {
//       defaultTextStyle = theme.textTheme.bodyText2!.copyWith(
//         color: Colors.white,
//         fontSize: _getDefaultFontSize(),
//       );
//       defaultDecoration = BoxDecoration(
//         color: Colors.grey[700]!.withOpacity(0.9),
//         borderRadius: const BorderRadius.all(Radius.circular(4)),
//       );
//     }

//     _height = widget.height ?? tooltipTheme.height ?? _getDefaultTooltipHeight();
//     _padding = widget.padding ?? tooltipTheme.padding ?? _getDefaultPadding();
//     _margin = widget.margin ?? tooltipTheme.margin ?? _defaultMargin;
//     _verticalOffset = widget.verticalOffset ?? tooltipTheme.verticalOffset ?? _defaultVerticalOffset;
//     _preferBelow = widget.preferBelow ?? tooltipTheme.preferBelow ?? _defaultPreferBelow;
//     _excludeFromSemantics = widget.excludeFromSemantics ?? tooltipTheme.excludeFromSemantics ?? _defaultExcludeFromSemantics;
//     _decoration = widget.decoration ?? tooltipTheme.decoration ?? defaultDecoration;
//     _textStyle = widget.textStyle ?? tooltipTheme.textStyle ?? defaultTextStyle;
//     _textAlign = widget.textAlign ?? tooltipTheme.textAlign ?? _defaultTextAlign;
//     _waitDuration = widget.waitDuration ?? tooltipTheme.waitDuration ?? _defaultWaitDuration;
//     _showDuration = widget.showDuration ?? tooltipTheme.showDuration ?? _defaultShowDuration;
//     _hoverShowDuration = widget.showDuration ?? tooltipTheme.showDuration ?? _defaultHoverShowDuration;
//     _enableFeedback = widget.enableFeedback ?? tooltipTheme.enableFeedback ?? _defaultEnableFeedback;

//     Widget result = Semantics(
//       tooltip: _excludeFromSemantics
//           ? null
//           : _tooltipMessage,
//       child: widget.child,
//     );

//     // Only check for gestures if tooltip should be visible.
//     if (_visible) {
//       result = GestureDetector(
//         behavior: HitTestBehavior.opaque,
//         excludeFromSemantics: true,
//         child: result,
//       );
//       // Only check for hovering if there is a mouse connected.
//       if (_mouseIsConnected) {
//         result = MouseRegion(
//           onEnter: (_) => _handleMouseEnter(),
//           onExit: (_) => _handleMouseExit(),
//           child: result,
//         );
//       }

//       result = Focus(
//         onFocusChange: (hasFocus) {
//           if (hasFocus) {
//             _handleMouseEnter();
//           } else {
//             _handleMouseExit();
//           }
//         },
//         child: result,
//       );
//     }

//     return result;
//   }
// }

// /// A delegate for computing the layout of a tooltip to be displayed above or
// /// below a target specified in the global coordinate system.
// class _TooltipPositionDelegate extends SingleChildLayoutDelegate {
//   /// Creates a delegate for computing the layout of a tooltip.
//   ///
//   /// The arguments must not be null.
//   _TooltipPositionDelegate({
//     required this.target,
//     required this.verticalOffset,
//     required this.preferBelow,
//   });

//   /// The offset of the target the tooltip is positioned near in the global
//   /// coordinate system.
//   final Offset target;

//   /// The amount of vertical distance between the target and the displayed
//   /// tooltip.
//   final double verticalOffset;

//   /// Whether the tooltip is displayed below its widget by default.
//   ///
//   /// If there is insufficient space to display the tooltip in the preferred
//   /// direction, the tooltip will be displayed in the opposite direction.
//   final bool preferBelow;

//   @override
//   BoxConstraints getConstraintsForChild(BoxConstraints constraints) => constraints.loosen();

//   @override
//   Offset getPositionForChild(Size size, Size childSize) {
//     return positionDependentBox(
//       size: size,
//       childSize: childSize,
//       target: target,
//       verticalOffset: verticalOffset,
//       preferBelow: preferBelow,
//     );
//   }

//   @override
//   bool shouldRelayout(_TooltipPositionDelegate oldDelegate) {
//     return target != oldDelegate.target
//         || verticalOffset != oldDelegate.verticalOffset
//         || preferBelow != oldDelegate.preferBelow;
//   }
// }

// class _TooltipOverlay extends StatelessWidget {
//   const _TooltipOverlay({
//     required this.height,
//     required this.richMessage,
//     this.padding,
//     this.margin,
//     this.decoration,
//     this.textStyle,
//     this.textAlign,
//     required this.animation,
//     required this.target,
//     required this.verticalOffset,
//     required this.preferBelow,
//     this.onEnter,
//     this.onExit,
//   });

//   final InlineSpan richMessage;
//   final double height;
//   final EdgeInsetsGeometry? padding;
//   final EdgeInsetsGeometry? margin;
//   final Decoration? decoration;
//   final TextStyle? textStyle;
//   final TextAlign? textAlign;
//   final Animation<double> animation;
//   final Offset target;
//   final double verticalOffset;
//   final bool preferBelow;
//   final PointerEnterEventListener? onEnter;
//   final PointerExitEventListener? onExit;

//   @override
//   Widget build(BuildContext context) {
//     Widget result = IgnorePointer(
//       child: FadeTransition(
//         opacity: animation,
//         child: ConstrainedBox(
//           constraints: BoxConstraints(minHeight: height),
//           child: DefaultTextStyle(
//             style: Theme.of(context).textTheme.bodyText2!,
//             child: Container(
//               decoration: decoration,
//               padding: padding,
//               margin: margin,
//               child: Center(
//                 widthFactor: 1.0,
//                 heightFactor: 1.0,
//                 child: Text.rich(
//                   richMessage,
//                   style: textStyle,
//                   textAlign: textAlign,
//                 ),
//               ),
//             ),
//           ),
//         ),
//       )
//     );
//     if (onEnter != null || onExit != null) {
//       result = MouseRegion(
//         onEnter: onEnter,
//         onExit: onExit,
//         child: result,
//       );
//     }
//     return Positioned.fill(
//       bottom: MediaQuery.maybeOf(context)?.viewInsets.bottom ?? 0.0,
//       child: CustomSingleChildLayout(
//         delegate: _TooltipPositionDelegate(
//           target: target,
//           verticalOffset: verticalOffset,
//           preferBelow: preferBelow,
//         ),
//         child: result,
//       ),
//     );
//   }
// }
