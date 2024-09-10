
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class OnHoverText extends StatefulWidget {
  final Widget Function(bool isHovered) builder;
  const OnHoverText({Key? key, required this.builder}) : super(key: key);

  @override
  State<OnHoverText> createState() => _OnHoverTextState();
}

class _OnHoverTextState extends State<OnHoverText> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final hoveredTransform = Matrix4.identity()..scale(1.1);
    final transform = isHovered ? hoveredTransform : Matrix4.identity();
    return MouseRegion(
      onEnter: (event) => onEntered(true),
      onExit: (event) => onEntered(false),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        // transform: transform,
        child: widget.builder(isHovered),
      ),
    );
  }

  onEntered(bool isHovered) => setState(() {
    this.isHovered = isHovered;
  });
}

extension HoverExtension on Widget {
  Widget get translateOnHover {
    return kIsWeb ? TranslateOnHover(child: this) : ThisContainer(child: this);
  }
}

class ThisContainer extends StatelessWidget {
  ThisContainer({this.child});
  final child;
  @override
  Widget build(BuildContext context) {
    return Container(child: child);
  }
}

class TranslateOnHover extends StatefulWidget {
  final Widget child;
  TranslateOnHover({required this.child});

  @override
  _TranslateOnHoverState createState() => _TranslateOnHoverState();
}

class _TranslateOnHoverState extends State<TranslateOnHover> {
  double scale = 1.0;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (e) => _mouseEnter(true),
      onExit: (e) => _mouseEnter(false),
      child: TweenAnimationBuilder(
        duration: const Duration(milliseconds: 200),
        tween: Tween<double>(begin: 1.0, end: scale),
        builder: (BuildContext context, double value, _) {
          return Transform.scale(scale: value, child: widget.child);
        },
      ),
    );
  }

  void _mouseEnter(bool hover) {
    setState(() {
      if (hover)
        scale = 5.0;
      else
        scale = 1.0;
    });
  }
}

