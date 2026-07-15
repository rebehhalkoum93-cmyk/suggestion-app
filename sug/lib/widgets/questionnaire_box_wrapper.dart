import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/category_theme.dart';

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
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Question Box
        QuestionTextContainer(question: question),

        const SizedBox(height: 20),

        // Options Stack
        RadioSelectionGroup(
          options: options,
          selectedIndex: selectedIndex,
          category: category,
          onSelected: onSelected,
        ),
      ],
    );
  }
}

class QuestionTextContainer extends StatelessWidget {
  final String question;

  const QuestionTextContainer({super.key, required this.question});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withValues(alpha: 0.35), width: 1.0),
      ),
      child: Text(
        question.toLowerCase(),
        style: GoogleFonts.montserrat(
          color: Colors.white,
          fontSize: 12.5,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.4,
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
          if (i < options.length - 1) const SizedBox(height: 10),
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

    final defaultBorderColor = Colors.white.withValues(alpha: 0.22);
    final defaultTextColor = Colors.white.withValues(alpha: 0.7);

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
            // Compact vertical padding — let the text wrap naturally
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(14),
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
                // Smaller radio circle (20 → 18px) to save horizontal space
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 18,
                  height: 18,
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
                            width: 6,
                            height: 6,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                          ),
                        )
                      : null,
                ),
                const SizedBox(width: 12),

                // Text allowed to wrap across multiple lines
                Expanded(
                  child: Text(
                    widget.text.toLowerCase(),
                    style: GoogleFonts.montserrat(
                      color: isSelected ? themeColor : defaultTextColor,
                      fontSize: 12,
                      fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
                      letterSpacing: 0.3,
                      height: 1.45,
                    ),
                    // Allow wrapping — no maxLines limit
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
