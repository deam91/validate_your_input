import 'package:flutter/cupertino.dart';

class AnimatedFieldWrapper extends StatefulWidget {
  const AnimatedFieldWrapper({Key? key, required this.child, this.focus})
      : super(key: key);
  final Widget child;
  final bool? focus;

  @override
  State<AnimatedFieldWrapper> createState() => _AnimatedFieldWrapperState();
}

class _AnimatedFieldWrapperState extends State<AnimatedFieldWrapper> {
  bool _hasFocus = false;
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _hasFocus = widget.focus ?? false;
    _focusNode.addListener(() {
      setState(() => _hasFocus = _focusNode.hasFocus);
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Focus.withExternalFocusNode(
      focusNode: _focusNode,
      child: AnimatedScale(
        scale: _hasFocus ? 1.05 : 1.0,
        duration: const Duration(milliseconds: 150),
        child: widget.child,
      ),
    );
  }
}
