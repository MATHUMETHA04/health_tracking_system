import 'package:flutter/material.dart';

class AuthButton extends StatefulWidget {
  final String text;
  final Color color;
  final VoidCallback onPressed;
  final bool isAnimated;

  const AuthButton({
    super.key,
    required this.text,
    required this.color,
    required this.onPressed,
    this.isAnimated = false,
  });

  @override
  State<AuthButton> createState() => _AuthButtonState();
}

class _AuthButtonState extends State<AuthButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      onTapDown: widget.isAnimated ? (_) => setState(() => _isHovered = true) : null,
      onTapUp: widget.isAnimated ? (_) => setState(() => _isHovered = false) : null,
      onTapCancel: widget.isAnimated ? () => setState(() => _isHovered = false) : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: widget.isAnimated ? 200 : null,
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: BorderRadius.circular(30),
          boxShadow: _isHovered && widget.isAnimated
              ? [
                  BoxShadow(
                    color: widget.color.withOpacity(0.5),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ]
              : [],
        ),
        child: Center(
          child: Text(
            widget.text,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
      ),
    );
  }
}