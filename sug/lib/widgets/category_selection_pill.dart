import 'package:flutter/material.dart';
import '../models/category_theme.dart';
import '../models/language_settings.dart';

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

class _CategorySelectionPillState extends State<CategorySelectionPill>
    with SingleTickerProviderStateMixin {
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
    final isGlow = _isHovered || _isPressed;

    final screenH = MediaQuery.of(context).size.height;
    final screenW = MediaQuery.of(context).size.width;
    final s = screenH / 812.0;
    final sw = screenW / 375.0;

    final pillWidth = (280 * sw).clamp(240.0, 400.0);
    final pillHeight = (68 * s).clamp(56.0, 100.0);
    final iconCircle = (44 * s).clamp(36.0, 64.0);
    final iconSize = (20 * s).clamp(16.0, 30.0);
    final iconLabelGap = (18 * sw).clamp(14.0, 28.0);
    final labelFontSize = (18) * s;
    final innerHPad = (14 * sw).clamp(10.0, 24.0);

    return ValueListenableBuilder<Language>(
      valueListenable: LanguageSettings.currentLanguage,
      builder: (context, lang, _) {
        final displayName = widget.category.displayName;
        final isArabic = LanguageSettings.isArabic;

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
                width: pillWidth,
                height: pillHeight,
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
                  padding: EdgeInsets.symmetric(horizontal: innerHPad),
                  child: Directionality(
                    textDirection: isArabic
                        ? TextDirection.rtl
                        : TextDirection.ltr,
                    child: Row(
                      children: [
                        // Circular boundary with icon
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          width: iconCircle,
                          height: iconCircle,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.black.withValues(alpha: 0.8),
                            border: Border.all(
                              color: isGlow
                                  ? color
                                  : color.withValues(alpha: 0.4),
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
                              size: iconSize,
                            ),
                          ),
                        ),
                        SizedBox(width: iconLabelGap),

                        // High-contrast title label text
                        Expanded(
                          child: Text(
                            displayName,
                            style: LanguageSettings.font(
                              color: Colors.white,
                              fontSize: labelFontSize,
                              fontWeight: FontWeight.w500,
                              letterSpacing: isArabic ? 0.0 : 0.8,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
