import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/category_theme.dart';
import '../widgets/ambient_glow_background.dart';
import '../widgets/questionnaire_box_wrapper.dart';
import '../widgets/system_navigation_button.dart';
import 'recommendation_page.dart';

import '../models/recommendation_questions.dart';

class QuestionnairePage extends StatefulWidget {
  final CategoryType category;

  const QuestionnairePage({super.key, required this.category});

  @override
  State<QuestionnairePage> createState() => _QuestionnairePageState();
}

class _QuestionnairePageState extends State<QuestionnairePage>
    with SingleTickerProviderStateMixin {
  int _currentQuestionIndex = 0;
  int? _selectedOptionIndex;
  final List<int> _selectedAnswers = [];

  late final List<SurveyQuestion> _questions;

  // Animation controller for page slide transitions
  late final AnimationController _slideController;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _questions = getQuestionsFor(widget.category);

    _slideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 280),
    );
    _slideAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic));
  }

  @override
  void dispose() {
    _slideController.dispose();
    super.dispose();
  }

  Future<void> _animateToNext(bool forward) async {
    final enterOffset = forward ? const Offset(1.0, 0) : const Offset(-1.0, 0);
    final exitOffset = forward ? const Offset(-1.0, 0) : const Offset(1.0, 0);

    // Slide current question out
    _slideAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: exitOffset,
    ).animate(CurvedAnimation(parent: _slideController, curve: Curves.easeInCubic));

    _slideController.reset();
    await _slideController.forward();

    // Update state (new question appears)
    if (mounted) setState(() {});

    // Slide new question in
    _slideAnimation = Tween<Offset>(
      begin: enterOffset,
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic));

    _slideController.reset();
    _slideController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = _questions[_currentQuestionIndex];
    final themeColor = widget.category.accentColor;
    final progress = (_currentQuestionIndex + 1) / _questions.length;

    return AmbientGlowBackground(
      category: widget.category,
      glowPositions: const [Alignment.topRight, Alignment.bottomLeft],
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ── Header row ────────────────────────────────────────────────
            Row(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Colors.white70,
                    size: 20,
                  ),
                  onPressed: _handleBack,
                ),
                const Spacer(),
                Text(
                  '${_currentQuestionIndex + 1} of ${_questions.length}',
                  style: GoogleFonts.montserrat(
                    color: Colors.white30,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            // ── Animated progress bar ─────────────────────────────────────
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0, end: progress),
                duration: const Duration(milliseconds: 380),
                curve: Curves.easeOutCubic,
                builder: (context, value, _) {
                  return LinearProgressIndicator(
                    value: value,
                    minHeight: 3,
                    backgroundColor: Colors.white.withValues(alpha: 0.08),
                    valueColor: AlwaysStoppedAnimation<Color>(themeColor),
                  );
                },
              ),
            ),

            const SizedBox(height: 10),

            // ── Instruction label ─────────────────────────────────────────
            Center(
              child: Text(
                'please answer the following questions',
                style: GoogleFonts.montserrat(
                  color: Colors.white.withValues(alpha: 0.35),
                  fontSize: 11,
                  fontWeight: FontWeight.w300,
                  letterSpacing: 0.6,
                ),
              ),
            ),

            const SizedBox(height: 18),

            // ── Scrollable question + options (prevents hard overflow) ─────
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: SlideTransition(
                  position: _slideAnimation,
                  child: QuestionnaireBoxWrapper(
                    key: ValueKey(_currentQuestionIndex),
                    question: currentQuestion.questionText,
                    options: currentQuestion.options.map((o) => o.text).toList(),
                    selectedIndex: _selectedOptionIndex,
                    category: widget.category,
                    onSelected: (index) {
                      setState(() {
                        _selectedOptionIndex = index;
                      });
                    },
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // ── Next button (always pinned at bottom) ─────────────────────
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                AnimatedOpacity(
                  opacity: _selectedOptionIndex != null ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 200),
                  child: IgnorePointer(
                    ignoring: _selectedOptionIndex == null,
                    child: SystemNavigationButton.next(
                      category: widget.category,
                      onPressed: _handleNext,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 7),
          ],
        ),
      ),
    );
  }

  void _handleBack() {
    if (_currentQuestionIndex > 0) {
      final prevAnswer = _selectedAnswers.last;
      _selectedAnswers.removeLast();
      _currentQuestionIndex--;
      _selectedOptionIndex = prevAnswer;
      _animateToNext(false);
    } else {
      Navigator.of(context).pop();
    }
  }

  void _handleNext() {
    if (_selectedOptionIndex == null) return;

    _selectedAnswers.add(_selectedOptionIndex!);

    if (_currentQuestionIndex < _questions.length - 1) {
      _currentQuestionIndex++;
      _selectedOptionIndex = null;
      _animateToNext(true);
    } else {
      // All questions answered → navigate to recommendations
      Navigator.of(context).push(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              RecommendationPage(
                category: widget.category,
                userAnswers: List.from(_selectedAnswers),
              ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
          transitionDuration: const Duration(milliseconds: 350),
        ),
      );
    }
  }
}
