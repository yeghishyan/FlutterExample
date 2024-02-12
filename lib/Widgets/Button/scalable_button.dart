import 'package:flutter/cupertino.dart';

class ScalableButton extends StatefulWidget {
  final Widget child;
  final Color? color;
  final double? minSize;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;
  final Function()? onPressed;

  const ScalableButton({
    super.key, 
    required this.child,
    this.color,
    this.minSize,
    this.borderRadius,
    this.padding,
    this.onPressed,
  });

  @override
  State<ScalableButton> createState() => _ScalableButtonState();
}

class _ScalableButtonState extends State<ScalableButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _handleTapDown(),
      onTapUp: (_) => _handleTapUp(),
      onTapCancel: () => _handleTapCancel(),
      onTap: widget.onPressed,
      child: ScaleTransition(
        scale: Tween<double>(begin: 1.0, end: 0.9).animate(_controller),
        child: CupertinoButton(
            color: widget.color,
            minSize: widget.minSize,
            borderRadius: widget.borderRadius,
            padding: widget.padding,
            onPressed: widget.onPressed,
            child: widget.child),
      ),
    );
  }

  void _handleTapDown() {
    setState(() {
      _controller.forward();
    });
  }

  void _handleTapUp() {
    setState(() {
      _controller.reverse();
    });
  }

  void _handleTapCancel() {
    setState(() {
      _controller.reverse();
    });
  }
}
