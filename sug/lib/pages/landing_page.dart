import 'package:flutter/material.dart';
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

        final screenH = MediaQuery.of(context).size.height;
        final screenW = MediaQuery.of(context).size.width;
        final s = screenH / 812.0;
        final sw = screenW / 375.0;

        return AmbientGlowBackground(
          category: null,
          glowPositions: const [
            Alignment.topRight,
            Alignment.bottomLeft,
          ],
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24 * sw, vertical: 20 * s),
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
                        padding: EdgeInsets.symmetric(horizontal: 12 * sw, vertical: 6 * s),
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
                              size: (14 * s).clamp(12.0, 20.0),
                              color: Colors.white.withValues(alpha: 0.8),
                            ),
                            SizedBox(width: 6 * sw),
                            Text(
                              isArabic ? 'English' : 'العربية',
                              style: LanguageSettings.font(
                                color: Colors.white.withValues(alpha: 0.8),
                                fontSize: (11 * s).clamp(9.0, 16.0),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                
                Spacer(flex: 2),
                
                // Centered selection pill container
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CategorySelectionPill(
                        category: CategoryType.music,
                        onTap: () => _navigateToQuestionnaire(context, CategoryType.music),
                      ),
                      SizedBox(height: 24 * s),
                      CategorySelectionPill(
                        category: CategoryType.movie,
                        onTap: () => _navigateToQuestionnaire(context, CategoryType.movie),
                      ),
                      SizedBox(height: 24 * s),
                      CategorySelectionPill(
                        category: CategoryType.series,
                        onTap: () => _navigateToQuestionnaire(context, CategoryType.series),
                      ),
                    ],
                  ),
                ),
                
                Spacer(flex: 3),
                
                // Footer branding anchor
                Text(
                  isArabic ? 'أنشئ بواسطة رابح' : 'created by rebeh',
                  style: LanguageSettings.font(
                    color: Colors.white.withValues(alpha: 0.3),
                    fontSize: (12 * s).clamp(10.0, 17.0),
                    fontWeight: FontWeight.w400,
                    letterSpacing: isArabic ? 0.0 : 1.2,
                  ),
                ),
                
                SizedBox(height: 12 * s),
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
