import 'package:flutter/material.dart';

class ScrollableText extends StatefulWidget {
  final String text;
  final TextStyle? style;
  final bool enabled;

  const ScrollableText({
    super.key,
    required this.text,
    this.style,
    this.enabled = false,
  });

  @override
  State<ScrollableText> createState() => _ScrollableTextState();
}

class _ScrollableTextState extends State<ScrollableText> {
  final _scrollController = ScrollController();
  bool scrollAnimationComplete = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      // scrollAnimationComplete = (!mounted || !widget.enabled);
      if (!mounted) {
        return;
      } else if (!widget.enabled) {
        scrollAnimationComplete = true;
        _scrollController.jumpTo(0);
        return;
      }

      if (scrollAnimationComplete && widget.enabled) {
        scrollAnimationComplete = false;
        Future.delayed(const Duration(seconds: 2), () async {
          scrollAnimationComplete = (!mounted || !widget.enabled);
          if (!mounted || !widget.enabled) {
            //_scrollController.jumpTo(0);
            return;
          }

          final maxExtent = _scrollController.position.maxScrollExtent;
          final speed = (maxExtent).toInt();
          await _scrollController.position.moveTo(
            maxExtent,
            duration: Duration(milliseconds: 20 * speed),
            curve: Curves.linear,
          );

          scrollAnimationComplete = (!mounted || !widget.enabled);
          if (!mounted) {
            // _scrollController.jumpTo(0);
            return;
          } else if (!widget.enabled) {
            _scrollController.jumpTo(0);
            return;
          }

          await Future.delayed(const Duration(seconds: 3));

          scrollAnimationComplete = (!mounted || !widget.enabled);
          if (!mounted) {
            return;
          } else if (!widget.enabled) {
            _scrollController.jumpTo(0);
            return;
          }

          await _scrollController.animateTo(
            0,
            duration: kThemeAnimationDuration * 2,
            curve: Curves.easeOut,
          );

          setState(() {
            scrollAnimationComplete = true;
          });
        });
      }
    });

    return SingleChildScrollView(
      controller: _scrollController,
      scrollDirection: Axis.horizontal,
      child: Text(
        // 'uri: https://www.ts.kg/show/tengen_toppa_gurren_lagann uri: https://www.ts.kg/show/tengen_toppa_gurren_lagann uri: https://www.ts.kg/show/tengen_toppa_gurren_lagann',
        widget.text,
        softWrap: true,
        maxLines: 1,
        overflow: TextOverflow.fade,
        style: widget.style,
      ),
    );
  }
}
