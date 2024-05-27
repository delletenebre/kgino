import 'package:flutter/material.dart';

class KikaNavigationTile extends StatefulWidget {
  final FocusNode? focusNode;
  final Widget title;
  final Widget? icon;
  final void Function()? onTap;
  final bool focused;
  final bool selected;
  final bool expanded;

  const KikaNavigationTile({
    super.key,
    this.focusNode,
    required this.title,
    this.icon,
    this.onTap,
    this.focused = false,
    this.selected = false,
    this.expanded = false,
  });

  @override
  State<KikaNavigationTile> createState() => _KikaNavigationTileState();
}

class _KikaNavigationTileState extends State<KikaNavigationTile> {
  bool _focused = false;

  bool get _selected => (_focused || widget.focused);

  @override
  Widget build(context) {
    final theme = Theme.of(context);

    return Material(
      borderRadius: BorderRadius.circular(64.0),
      color: _selected ? theme.colorScheme.inverseSurface : Colors.transparent,
      child: InkWell(
        focusNode: widget.focusNode,
        borderRadius: BorderRadius.circular(64.0),
        //focusColor: theme.colorScheme.inverseSurface,
        // textColor: _focused
        //     ? theme.colorScheme.onInverseSurface
        //     : theme.colorScheme.onSurface,
        // iconColor: _focused
        //     ? theme.colorScheme.onInverseSurface
        //     : theme.colorScheme.onSurface,
        onTap: widget.onTap ?? () {},
        onFocusChange: (hasFocus) {
          setState(() {
            _focused = hasFocus;
          });
        },
        child: AnimatedContainer(
          duration: kThemeAnimationDuration,
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(64.0),
          ),
          child: Row(
            children: [
              if (widget.icon != null)
                IconTheme(
                  data: IconThemeData(
                    color: _selected
                        ? theme.colorScheme.onInverseSurface
                        : theme.colorScheme.onSurface,
                  ),
                  child: widget.icon!,
                ),
              //if (widget.title != null && widget.expanded)
              Expanded(
                child: AnimatedDefaultTextStyle(
                  softWrap: false,
                  duration: kThemeAnimationDuration,
                  style: theme.textTheme.titleMedium!.copyWith(
                    color: _selected
                        ? theme.colorScheme.onInverseSurface
                        : theme.colorScheme.onSurface,
                    fontSize: widget.expanded ? 16.0 : 0.0,
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.only(left: widget.icon != null ? 12.0 : 0.0),
                    child: widget.title,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
