import 'package:flutter/material.dart';

import '../pages/search/button_search_field.dart';
import 'krs_tab_bar_button.dart';

class KrsTabBar extends StatefulWidget implements PreferredSizeWidget {
  const KrsTabBar({
    super.key,
    required this.tabs,
    this.controller,
    this.duration = 250,
    this.physics = const BouncingScrollPhysics(),
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 4, vertical: 24.0),
    this.labelSpacing = 4.0,
    this.onTap,
    this.onFocusChanged,
  });

  final void Function(bool hasFocus)? onFocusChanged;

  /// Typically a list of two or more [Tab] widgets.
  ///
  /// The length of this list must match the [controller]'s [TabController.length]
  /// and the length of the [TabBarView.children] list.
  final List<Widget> tabs;

  /// This widget's selection and animation state.
  ///
  /// If [TabController] is not provided, then the value of [DefaultTabController.of]
  /// will be used.
  final TabController? controller;

  /// The duration in milliseconds of the transition animation.
  final int duration;

  /// The physics used for the [ScrollController] of the tabs list.
  ///
  /// The default value is [BouncingScrollPhysics].
  final ScrollPhysics physics;

  /// The [EdgeInsets] used for the [Padding] of the buttons' content.
  ///
  /// The default value is [EdgeInsets.symmetric(horizontal: 4)].
  final EdgeInsets contentPadding;

  /// The spacing between the [Icon] and the [Text]. If only one of those is provided,
  /// no spacing is applied.
  final double labelSpacing;

  /// An optional callback that's called when the [TabBar] is tapped.
  ///
  /// The callback is applied to the index of the tab where the tap occurred.
  ///
  /// This callback has no effect on the default handling of taps. It's for
  /// applications that want to do a little extra work when a tab is tapped,
  /// even if the tap doesn't change the [TabController]'s index. [TabBar] onTap
  /// callbacks should not make changes to the [TabController] since that would
  /// interfere with the default tap handler.
  final void Function(int)? onTap;

  @override
  Size get preferredSize {
    return Size.fromHeight(40.0 + contentPadding.vertical);
  }

  @override
  createState() => _KrsTabBarState();
}

class _KrsTabBarState extends State<KrsTabBar>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  TabController? _controller;

  final ScrollController _scrollController = ScrollController();

  late AnimationController _animationController;

  late List<GlobalKey> _tabKeys;
  late List<FocusNode> _tabFocusNodes;
  // final GlobalKey _tabsParentKey = GlobalKey();

  int _currentIndex = 0;
  int _aniIndex = 0;
  double _prevAniValue = 0;

  bool _tabBarFocused = false;

  @override
  void initState() {
    super.initState();

    _tabKeys = widget.tabs.map((Widget tab) => GlobalKey()).toList();

    /// инициализируем список [FocusNode]
    _tabFocusNodes = List.generate(widget.tabs.length, (index) => FocusNode());

    /// инициализаруем [AnimationController]
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.duration),
    );

    // so the buttons start in their "final" state (color)
    _animationController.value = 1.0;
    _animationController.addListener(() {
      setState(() {});
    });
  }

  void _updateTabController() {
    final TabController newController =
        widget.controller ?? DefaultTabController.of(context);

    if (newController == _controller) {
      return;
    }

    if (_controllerIsValid) {
      _controller?.animation!.removeListener(_handleTabAnimation);
      _controller?.removeListener(_handleController);
    }
    _controller = newController;
    _controller?.animation!.addListener(_handleTabAnimation);
    _controller?.addListener(_handleController);
    _currentIndex = _controller!.index;
  }

  // If the TabBar is rebuilt with a new tab controller, the caller should
  // dispose the old one. In that case the old controller's animation will be
  // null and should not be accessed.
  bool get _controllerIsValid => _controller?.animation != null;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    assert(debugCheckHasMaterial(context));
    _updateTabController();
  }

  @override
  void didUpdateWidget(KrsTabBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      _updateTabController();
    }

    if (widget.tabs.length > oldWidget.tabs.length) {
      final int delta = widget.tabs.length - oldWidget.tabs.length;
      _tabKeys.addAll(List<GlobalKey>.generate(delta, (int n) => GlobalKey()));
    } else if (widget.tabs.length < oldWidget.tabs.length) {
      _tabKeys.removeRange(widget.tabs.length, oldWidget.tabs.length);
    }
  }

  void _handleController() {
    if (_controller!.indexIsChanging) {
      // update highlighted index when controller index is changing
      _goToIndex(_controller!.index);
    }
  }

  @override
  void dispose() {
    if (_controllerIsValid) {
      _controller!.animation!.removeListener(_handleTabAnimation);
      _controller!.removeListener(_handleController);
    }
    _controller = null;
    _scrollController.dispose();
    
    for (final focusNode in _tabFocusNodes) {
      focusNode.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    assert(() {
      if (_controller!.length != widget.tabs.length) {
        throw FlutterError(
            "Controller's length property (${_controller!.length}) does not match the "
            "number of tabs (${widget.tabs.length}) present in TabBar's tabs property.");
      }
      return true;
    }());

    return Focus(
      skipTraversal: true,
      onFocusChange: (hasFocus) {
        widget.onFocusChanged?.call(hasFocus);

        if (!_tabBarFocused && hasFocus) {
          /// ^ если до этого не было фокуса и фокус стал активен
          
          /// ставим фокус на текущую вкладку
          _tabFocusNodes[_controller!.index].requestFocus();
        }

        if (_tabBarFocused != hasFocus) {
          // ^ если состояние фокуса изменилось
          
          // запоминаем состояние фокуса на [TabBar]
          setState(() {
            _tabBarFocused = hasFocus;
          });
        }
      },
      child: SizedBox(
        height: 40.0,
        child: ListView(
          controller: _scrollController,
          scrollDirection: Axis.horizontal,
          children: List.generate(widget.tabs.length, (index) {
            final tab = widget.tabs[index] as Tab;

            if (index == 0) {
              // если в текущий выбор - поиск
              
              return ButtonSearchField(
                focusNode: _tabFocusNodes[index],
                selected: _controller?.index == index,
                active: _tabBarFocused,
                onFocusChange: (hasFocus) {
                  if (_tabBarFocused && hasFocus) {
                    _controller?.animateTo(index);
                    widget.onTap?.call(index);
                  }
                },
                onPressed: () {
                  _controller?.animateTo(index);
                  widget.onTap?.call(index);
                },
                labelText: tab.text ?? '', 
              );

            }

            return KrsTabBarButton(
              focusNode: _tabFocusNodes[index],
              selected: _controller?.index == index,
              active: _tabBarFocused,
              onFocusChange: (hasFocus) {
                if (_tabBarFocused && hasFocus) {
                  _controller?.animateTo(index);
                  widget.onTap?.call(index);
                }
              },
              onPressed: () {
                _controller?.animateTo(index);
                widget.onTap?.call(index);
              },
              icon: tab.icon,
              labelText: tab.text ?? '', 
            );
          }),
        ),
      )
    );
  }

  // runs during the switching tabs animation
  _handleTabAnimation() {
    _aniIndex = ((_controller!.animation!.value > _prevAniValue)
            ? _controller!.animation!.value
            : _prevAniValue)
        .round();
    if (!_controller!.indexIsChanging && _aniIndex != _currentIndex) {
      _setCurrentIndex(_aniIndex);
    }
    _prevAniValue = _controller!.animation!.value;
  }

  _goToIndex(int index) {
    if (index != _currentIndex) {
      _setCurrentIndex(index);
      //_controller?.animateTo(index);
    }
  }

  _setCurrentIndex(int index) {
    if (_currentIndex != index) {
      // change the index
      setState(() {
        _currentIndex = index;
      });
      //_scrollTo(index); // scroll TabBar if needed
      //_triggerAnimation();
    }
  }

  // _triggerAnimation() {
  //   // reset the animation so it's ready to go
  //   _animationController.reset();

  //   // run the animation!
  //   _animationController.forward();
  // }
}
