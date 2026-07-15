import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/category_theme.dart';

class CategorySelectionPill extends StatefulWidget {
  final CategoryType category;
  final VoidCallback onTap;

  const CategorySelectionPill({
    super.key,
    required this.category,
    required this.onTap,
  });

  @override
  State<CategorySelectionPill> createState() => _CategorySelectionPillState();
}

class _CategorySelectionPillState extends State<CategorySelectionPill> with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  bool _isPressed = false;
  
  late AnimationController _animController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.97).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = widget.category.accentColor;
    final displayName = widget.category.displayName;
    final isGlow = _isHovered || _isPressed;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTapDown: (_) {
          _animController.forward();
          setState(() => _isPressed = true);
        },
        onTapUp: (_) {
          _animController.reverse();
          setState(() => _isPressed = false);
          widget.onTap();
        },
        onTapCancel: () {
          _animController.reverse();
          setState(() => _isPressed = false);
        },
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOutCubic,
            width: 280,
            height: 68,
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.55),
              borderRadius: BorderRadius.circular(999),
              border: Border.all(
                color: isGlow ? color : color.withValues(alpha: 0.35),
                width: isGlow ? 1.8 : 1.0,
              ),
              boxShadow: [
                BoxShadow(
                  color: color.withValues(alpha: isGlow ? 0.5 : 0.15),
                  blurRadius: isGlow ? 20 : 10,
                  spreadRadius: isGlow ? 1 : 0,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Row(
                children: [
                  // Left Slot: Circular boundary with centered vector-style icon
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black.withValues(alpha: 0.8),
                      border: Border.all(
                        color: isGlow ? color : color.withValues(alpha: 0.4),
                        width: 1.5,
                      ),
                      boxShadow: [
                        if (isGlow)
                          BoxShadow(
                            color: color.withValues(alpha: 0.3),
                            blurRadius: 6,
                            spreadRadius: 0.5,
                          ),
                      ],
                    ),
                    child: Center(
                      child: widget.category.buildIconWidget(
                        color: color,
                        size: 20,
                      ),
                    ),
                  ),
                  const SizedBox(width: 18),
                  
                  // Right Slot: High-contrast title label text
                  Expanded(
                    child: Text(
                      displayName,
                      style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
