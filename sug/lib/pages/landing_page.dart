import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/category_theme.dart';
import '../widgets/ambient_glow_background.dart';
import '../widgets/category_selection_pill.dart';
import 'questionnaire_page.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AmbientGlowBackground(
      // Landing page defaults to the default electric blue/mixed glow positions
      category: null,
      glowPositions: const [
        Alignment.topRight,
        Alignment.bottomLeft,
      ],
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Column(
          children: [
            // Top uninhibited space (reserved for status bar or system UI)
            const Spacer(flex: 2),
            
            // Centered selection pill container
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CategorySelectionPill(
                    category: CategoryType.music,
                    onTap: () => _navigateToQuestionnaire(context, CategoryType.music),
                  ),
                  const SizedBox(height: 24),
                  CategorySelectionPill(
                    category: CategoryType.movie,
                    onTap: () => _navigateToQuestionnaire(context, CategoryType.movie),
                  ),
                  const SizedBox(height: 24),
                  CategorySelectionPill(
                    category: CategoryType.series,
                    onTap: () => _navigateToQuestionnaire(context, CategoryType.series),
                  ),
                ],
              ),
            ),
            
            const Spacer(flex: 3),
            
            // Footer branding anchor
            Text(
              'created by rebeh',
              style: GoogleFonts.montserrat(
                color: Colors.white.withValues(alpha: 0.3),
                fontSize: 12,
                fontWeight: FontWeight.w400,
                letterSpacing: 1.2,
              ),
            ),
            
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  void _navigateToQuestionnaire(BuildContext context, CategoryType category) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => QuestionnairePage(category: category),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 300),
      ),
    );
  }
}
