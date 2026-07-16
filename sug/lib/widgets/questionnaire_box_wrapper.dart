import 'package:flutter/material.dart';
import '../models/category_theme.dart';
import '../models/language_settings.dart';

class QuestionnaireBoxWrapper extends StatelessWidget {
  final String question;
  final List<String> options;
  final int? selectedIndex;
  final CategoryType category;
  final ValueChanged<int> onSelected;

  const QuestionnaireBoxWrapper({
    super.key,
    required this.question,
    required this.options,
    required this.selectedIndex,
    required this.category,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final isArabic = LanguageSettings.isArabic;
    final screenH = MediaQuery.of(context).size.height;
    final s = screenH / 812.0;

    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Question Box
          QuestionTextContainer(question: question),

          SizedBox(height: 20 * s),

          // Options Stack
          RadioSelectionGroup(
            options: options,
            selectedIndex: selectedIndex,
            category: category,
            onSelected: onSelected,
          ),
        ],
      ),
    );
  }
}

class QuestionTextContainer extends StatelessWidget {
  final String question;

  const QuestionTextContainer({super.key, required this.question});

  @override
  Widget build(BuildContext context) {
    final isArabic = LanguageSettings.isArabic;
    final screenH = MediaQuery.of(context).size.height;
    final s = screenH / 812.0;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20 * s, vertical: 14 * s),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(12 * s),
        border: Border.all(color: Colors.white.withValues(alpha: 0.35), width: 1.0),
      ),
      child: Text(
        isArabic ? question : question.toLowerCase(),
        style: LanguageSettings.font(
          color: Colors.white,
          fontSize: (isArabic ? 14.5 : 12.5) * s,
          fontWeight: FontWeight.w400,
          letterSpacing: isArabic ? 0.0 : 0.4,
          height: 1.5,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class RadioSelectionGroup extends StatelessWidget {
  final List<String> options;
  final int? selectedIndex;
  final CategoryType category;
  final ValueChanged<int> onSelected;

  const RadioSelectionGroup({
    super.key,
    required this.options,
    required this.selectedIndex,
    required this.category,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final screenH = MediaQuery.of(context).size.height;
    final s = screenH / 812.0;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (int i = 0; i < options.length; i++) ...[
          RadioOptionItem(
            text: options[i],
            isSelected: selectedIndex == i,
            category: category,
            onTap: () => onSelected(i),
          ),
          if (i < options.length - 1) SizedBox(height: 10 * s),
        ],
      ],
    );
  }
}

class RadioOptionItem extends StatefulWidget {
  final String text;
  final bool isSelected;
  final CategoryType category;
  final VoidCallback onTap;

  const RadioOptionItem({
    super.key,
    required this.text,
    required this.isSelected,
    required this.category,
    required this.onTap,
  });

  @override
  State<RadioOptionItem> createState() => _RadioOptionItemState();
}

class _RadioOptionItemState extends State<RadioOptionItem>
    with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  late AnimationController _animController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.98).animate(
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
    final themeColor = widget.category.accentColor;
    final isSelected = widget.isSelected;
    final isArabic = LanguageSettings.isArabic;

    final screenH = MediaQuery.of(context).size.height;
    final s = screenH / 812.0;

    final defaultBorderColor = Colors.white.withValues(alpha: 0.22);
    final defaultTextColor = Colors.white.withValues(alpha: 0.7);

    final radioSize = (18 * s).clamp(16.0, 26.0);
    final dotSize = (6 * s).clamp(5.0, 9.0);
    final optionFontSize = (isArabic ? 13 : 12) * s;
    final optionHPad = (12 * s).clamp(10.0, 20.0);
    final optionVPad = (10 * s).clamp(8.0, 18.0);
    final radioTextGap = (12 * s).clamp(8.0, 18.0);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTapDown: (_) => _animController.forward(),
        onTapUp: (_) {
          _animController.reverse();
          widget.onTap();
        },
        onTapCancel: () => _animController.reverse(),
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOut,
            padding: EdgeInsets.symmetric(horizontal: optionHPad, vertical: optionVPad),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(14 * s),
              border: Border.all(
                color: isSelected
                    ? themeColor
                    : (_isHovered
                          ? themeColor.withValues(alpha: 0.45)
                          : defaultBorderColor),
                width: isSelected ? 1.5 : 1.0,
              ),
              boxShadow: [
                if (isSelected)
                  BoxShadow(
                    color: themeColor.withValues(alpha: 0.22),
                    blurRadius: 8,
                    spreadRadius: 0,
                  ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Radio circle
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: radioSize,
                  height: radioSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSelected
                          ? themeColor
                          : defaultBorderColor.withValues(alpha: 0.7),
                      width: 1.5,
                    ),
                    color: isSelected ? themeColor : Colors.transparent,
                  ),
                  child: isSelected
                      ? Center(
                          child: Container(
                            width: dotSize,
                            height: dotSize,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                          ),
                        )
                      : null,
                ),
                SizedBox(width: radioTextGap),

                // Text allowed to wrap across multiple lines
                Expanded(
                  child: Text(
                    isArabic ? widget.text : widget.text.toLowerCase(),
                    style: LanguageSettings.font(
                      color: isSelected ? themeColor : defaultTextColor,
                      fontSize: optionFontSize,
                      fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
                      letterSpacing: isArabic ? 0.0 : 0.3,
                      height: 1.45,
                    ),
                    softWrap: true,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
