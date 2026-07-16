import 'package:flutter/material.dart';
import '../models/category_theme.dart';
import '../models/language_settings.dart';

enum NavButtonType {
  next,
  home,
}

class SystemNavigationButton extends StatefulWidget {
  final CategoryType category;
  final NavButtonType type;
  final VoidCallback onPressed;

  const SystemNavigationButton({
    super.key,
    required this.category,
    required this.type,
    required this.onPressed,
  });

  const SystemNavigationButton.next({
    super.key,
    required this.category,
    required this.onPressed,
  }) : type = NavButtonType.next;

  const SystemNavigationButton.home({
    super.key,
    required this.category,
    required this.onPressed,
  }) : type = NavButtonType.home;

  @override
  State<SystemNavigationButton> createState() => _SystemNavigationButtonState();
}

class _SystemNavigationButtonState extends State<SystemNavigationButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = widget.category.accentColor;
    final isArabic = LanguageSettings.isArabic;

    final screenH = MediaQuery.of(context).size.height;
    final s = screenH / 812.0;
    
    // Gradient definitions mapping to the active theme color
    final primaryGradient = LinearGradient(
      colors: [
        color,
        Color.alphaBlend(Colors.black.withValues(alpha: 0.25), color),
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

    final nextHPad = (16 * s).clamp(12.0, 24.0);
    final nextVPad = (8 * s).clamp(6.0, 14.0);
    final homeHPad = (32 * s).clamp(24.0, 48.0);
    final homeVPad = (16 * s).clamp(12.0, 24.0);
    final nextFontSize = (13 * s).clamp(11.0, 18.0);
    final homeFontSize = (16 * s).clamp(13.0, 22.0);
    final iconCirclePad = (3 * s).clamp(2.0, 5.0);
    final iconSize = (11 * s).clamp(9.0, 16.0);
    final textIconGap = (6 * s).clamp(4.0, 10.0);

    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) {
        _controller.reverse();
        widget.onPressed();
      },
      onTapCancel: () => _controller.reverse(),
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          decoration: BoxDecoration(
            gradient: primaryGradient,
            borderRadius: widget.type == NavButtonType.next 
                ? BorderRadius.circular(999) 
                : BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha: 0.4),
                blurRadius: widget.type == NavButtonType.next ? 12 : 16,
                spreadRadius: 0,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Padding(
            padding: widget.type == NavButtonType.next
                ? EdgeInsets.symmetric(horizontal: nextHPad, vertical: nextVPad)
                : EdgeInsets.symmetric(horizontal: homeHPad, vertical: homeVPad),
            child: widget.type == NavButtonType.next
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        isArabic ? 'التالي' : 'Next',
                        style: LanguageSettings.font(
                          fontSize: nextFontSize,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: textIconGap),
                      Container(
                        padding: EdgeInsets.all(iconCirclePad),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          isArabic ? Icons.arrow_back_rounded : Icons.arrow_forward_rounded,
                          color: color,
                          size: iconSize,
                        ),
                      ),
                    ],
                  )
                : Text(
                    isArabic ? 'الصفحة الرئيسية' : 'Home Page',
                    style: LanguageSettings.font(
                      fontSize: homeFontSize,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
          ),
        ),
      ),
    );
  }
}
