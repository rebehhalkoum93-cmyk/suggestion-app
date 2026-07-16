import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../models/category_theme.dart';
import '../models/language_settings.dart';
import '../models/recommendation_questions.dart';
import '../services/api_config.dart';
import '../widgets/ambient_glow_background.dart';
import '../widgets/system_navigation_button.dart';

class MediaItem {
  final String title;
  final String? subtitle; // Music artist
  final String imagePath;
  final String? reason;
  final int? confidence;

  const MediaItem({
    required this.title,
    this.subtitle,
    required this.imagePath,
    this.reason,
    this.confidence,
  });
}

class RecommendationPage extends StatefulWidget {
  final CategoryType category;
  final List<int> userAnswers;

  const RecommendationPage({
    super.key,
    required this.category,
    required this.userAnswers,
  });

  @override
  State<RecommendationPage> createState() => _RecommendationPageState();
}

class _RecommendationPageState extends State<RecommendationPage> with SingleTickerProviderStateMixin {
  List<MediaItem> _currentRecommendations = [];
  final Set<String> _shownTitles = {}; // accumulates every title ever shown
  bool _isShuffling = false;
  bool _isLoading = true;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  late final Map<String, String> _backendTags;

  @override
  void initState() {
    super.initState();
    _backendTags = getAggregatedTags(widget.category, widget.userAnswers);
    debugPrint('REGISTERED BACKEND TAGS FOR ${widget.category.displayName}: $_backendTags');
    
    _fetchRecommendations();
    
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );
    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }


  Future<void> _fetchRecommendations() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final dio = Dio();

      final response = await dio.post(
        '${ApiConfig.baseUrl}${ApiConfig.recommendEndpoint}',
        data: {
          'category': widget.category.name,
          'answers': widget.userAnswers,
          'tags': _backendTags,
          'excluded_titles': _shownTitles.toList(),
        },
      ).timeout(ApiConfig.requestTimeout);

      if (response.statusCode == 200) {
        final List<dynamic> recsJson = response.data['recommendations'];
        final newItems = recsJson.map((item) {
          return MediaItem(
            title: item['title'] as String,
            subtitle: item['subtitle'] as String?,
            imagePath: item['imagePath'] as String,
            reason: item['reason'] as String?,
            confidence: item['confidence'] as int?,
          );
        }).toList();

        // Accumulate all titles ever shown
        for (final item in newItems) {
          _shownTitles.add(item.title.toLowerCase().trim());
        }

        setState(() {
          _currentRecommendations = newItems;
          _isLoading = false;
        });
      } else {
        throw Exception('Server returned ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Backend unreachable: $e');
      setState(() => _isLoading = false);
      // Show error — do NOT fall back to local mocks
      if (mounted) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (ctx) => AlertDialog(
            backgroundColor: const Color(0xFF111111),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            title: Text(
              'Backend Unreachable',
              style: LanguageSettings.font(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            content: Text(
              'Could not connect to the recommendation server.\n\nBackend URL:\n${ApiConfig.baseUrl}',
              style: LanguageSettings.font(
                color: Colors.white60,
                fontSize: 13,
                height: 1.6,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
                child: Text(
                  'Go Back',
                  style: LanguageSettings.font(color: Colors.white38),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                  _fetchRecommendations();
                },
                child: Text(
                  'Retry',
                  style: LanguageSettings.font(
                    color: widget.category.accentColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        );
      }
    }
  }

  void _handleRegenerate() async {
    if (_isShuffling || _isLoading) return;
    setState(() => _isShuffling = true);
    
    // Smooth fade out
    await _fadeController.reverse();
    
    await _fetchRecommendations();
    
    // Smooth fade in
    _fadeController.forward();
    setState(() => _isShuffling = false);
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = widget.category.accentColor;
    final lowercaseTitle = 'suggested ${widget.category.lowercaseLabel}';

    return AmbientGlowBackground(
      category: widget.category,
      glowPositions: const [
        Alignment.topRight,
        Alignment.bottomLeft,
      ],
      child: Stack(
        children: [
          // Content Layout
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header Structural Control Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      lowercaseTitle,
                      style: LanguageSettings.font(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0.5,
                      ),
                    ),
                    
                    // Regenerate Action Component
                    GestureDetector(
                      onTap: _handleRegenerate,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                        decoration: BoxDecoration(
                          color: themeColor,
                          borderRadius: BorderRadius.circular(6),
                          boxShadow: [
                            BoxShadow(
                              color: themeColor.withValues(alpha: 0.3),
                              blurRadius: 8,
                            ),
                          ],
                        ),
                        child: Text(
                          'regenerate',
                          style: LanguageSettings.font(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 14),
                
                // Active Backend Tags Ribbon (Visual feedback for registered answers)
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  child: Row(
                    children: _backendTags.entries.map((entry) {
                      return Container(
                        margin: const EdgeInsets.only(right: 8),
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.06),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: themeColor.withValues(alpha: 0.3),
                            width: 1.0,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '${entry.key}: ',
                              style: LanguageSettings.font(
                                color: Colors.white.withValues(alpha: 0.38),
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              entry.value,
                              style: LanguageSettings.font(
                                color: Colors.white.withValues(alpha: 0.87),
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
                
                const SizedBox(height: 20),
                
                // Animated Recommendation Area
                Expanded(
                  child: _isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        )
                      : FadeTransition(
                          opacity: _fadeAnimation,
                          child: widget.category == CategoryType.music
                              ? _buildMusicList()
                              : _buildMovieOrSeriesGrid(),
                        ),
                ),
                
                // Reserve space for Home Page button bottom anchor padding
                const SizedBox(height: 90),
              ],
            ),
          ),
          
          // Bottom Structural Control Row: Home Page navigation button
          Positioned(
            bottom: 24,
            left: 0,
            right: 0,
            child: Center(
              child: SystemNavigationButton.home(
                category: widget.category,
                onPressed: () {
                  // Navigate back to landing page by popping standard page stack
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Template 4: Linear Component Recommendation Row List (Music)
  Widget _buildMusicList() {
    return ListView.separated(
      physics: const ClampingScrollPhysics(),
      itemCount: _currentRecommendations.length,
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final track = _currentRecommendations[index];
        return Container(
          height: 76,
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.55),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.12),
              width: 1.0,
            ),
          ),
          child: Row(
            children: [
              // Left Side Element: Square crop media cover image bounding block containing track album art
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(11),
                  bottomLeft: Radius.circular(11),
                ),
                child: track.imagePath.startsWith('http')
                    ? Image.network(
                        track.imagePath,
                        width: 76,
                        height: 76,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          width: 76,
                          height: 76,
                          color: Colors.white.withValues(alpha: 0.08),
                          child: const Icon(Icons.music_note, color: Colors.white38),
                        ),
                      )
                    : Image.asset(
                        track.imagePath,
                        width: 76,
                        height: 76,
                        fit: BoxFit.cover,
                      ),
              ),
              const SizedBox(width: 20),
              
              // Right Side Element: Vertical centered text descriptors (starboy stacked on top of the weekend)
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      track.title.toLowerCase(),
                      style: LanguageSettings.font(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.5,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      track.subtitle?.toLowerCase() ?? '',
                      style: LanguageSettings.font(
                        color: Colors.white.withValues(alpha: 0.4),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0.5,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Template 3: Discrete Matrix Grid Recommendation Layout (Movies/Series)
  Widget _buildMovieOrSeriesGrid() {
    return GridView.builder(
      physics: const ClampingScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
        childAspectRatio: 0.72,
      ),
      itemCount: _currentRecommendations.length,
      itemBuilder: (context, index) {
        final item = _currentRecommendations[index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Matrix Media Block: Image card with rounded corners
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.12),
                    width: 1.0,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.4),
                      blurRadius: 6,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(11),
                  child: item.imagePath.startsWith('http')
                      ? Image.network(
                          item.imagePath,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Container(
                            color: Colors.white.withValues(alpha: 0.08),
                            child: const Center(
                              child: Icon(Icons.movie, color: Colors.white38, size: 40),
                            ),
                          ),
                        )
                      : Image.asset(
                          item.imagePath,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            
            // Underlying text metadata (e.g. movie1)
            Text(
              item.title.toLowerCase(),
              style: LanguageSettings.font(
                color: Colors.white.withValues(alpha: 0.65),
                fontSize: 14,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.5,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        );
      },
    );
  }
}
