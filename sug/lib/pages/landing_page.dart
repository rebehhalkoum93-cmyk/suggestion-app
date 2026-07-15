import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/category_theme.dart';
import '../models/language_settings.dart';
import '../widgets/ambient_glow_background.dart';
import '../widgets/category_selection_pill.dart';
import 'questionnaire_page.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Language>(
      valueListenable: LanguageSettings.currentLanguage,
      builder: (context, lang, _) {
        final isArabic = LanguageSettings.isArabic;

        return AmbientGlowBackground(
          category: null,
          glowPositions: const [
            Alignment.topRight,
            Alignment.bottomLeft,
          ],
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Column(
              children: [
                // Top header with language switch toggle button
                SafeArea(
                  child: Align(
                    alignment: isArabic ? Alignment.topLeft : Alignment.topRight,
                    child: GestureDetector(
                      onTap: () {
                        LanguageSettings.toggleLanguage();
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.15),
                            width: 1.0,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.language_rounded,
                              size: 14,
                              color: Colors.white.withValues(alpha: 0.8),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              isArabic ? 'English' : 'العربية',
                              style: GoogleFonts.montserrat(
                                color: Colors.white.withValues(alpha: 0.8),
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                
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
                  isArabic ? 'أنشئ بواسطة رابح' : 'created by rebeh',
                  style: GoogleFonts.montserrat(
                    color: Colors.white.withValues(alpha: 0.3),
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    letterSpacing: isArabic ? 0.0 : 1.2,
                  ),
                ),
                
                const SizedBox(height: 12),
              ],
            ),
          ),
        );
      },
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
