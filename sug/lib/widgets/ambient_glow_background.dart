import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/material.dart';
import '../models/category_theme.dart';

class AmbientGlowBackground extends StatefulWidget {
  final CategoryType? category;
  final Widget child;
  final List<Alignment>? glowPositions;

  const AmbientGlowBackground({
    super.key,
    this.category,
    required this.child,
    this.glowPositions,
  });

  @override
  State<AmbientGlowBackground> createState() => _AmbientGlowBackgroundState();
}

class _AmbientGlowBackgroundState extends State<AmbientGlowBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    // 12 seconds loop to circulate the screen boundary smoothly
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 12),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final accentColor = widget.category?.accentColor ?? const Color(0xFF0000FF);
    
    // Get screen dimensions for edge tracking calculations
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;

    return Scaffold(
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          // Base solid black canvas
          Container(
            color: Colors.black,
          ),
          
          // Animated Light Blobs Layer (Clockwise edge tracking)
          AnimatedBuilder(
            animation: _controller,
            builder: (context, _) {
              // angle progress in clockwise direction (0 to 2*pi)
              final angle = _controller.value * 2 * math.pi;
              
              // Calculate positions for two opposite glowing blobs orbiting the edge
              // Blob 1: tracking the current angle
              // Blob 2: offset by pi (opposite corner tracking)
              final blobs = [
                angle,
                angle + math.pi,
              ];

              return Stack(
                children: blobs.map((blobAngle) {
                  // orbit radius is set close to screen bounds to track the edges
                  final radiusX = screenWidth * 0.48;
                  final radiusY = screenHeight * 0.48;
                  
                  final centerX = screenWidth / 2;
                  final centerY = screenHeight / 2;

                  // Clockwise circular orbit matching math conventions in screen coordinates
                  final x = centerX + radiusX * math.cos(blobAngle);
                  final y = centerY + radiusY * math.sin(blobAngle);

                  // Center the 320x320 blob onto the calculated edge coordinate
                  final left = x - 160;
                  final top = y - 160;

                  return Positioned(
                    left: left,
                    top: top,
                    width: 320,
                    height: 320,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            accentColor.withValues(alpha: 0.4),
                            accentColor.withValues(alpha: 0.1),
                            Colors.transparent,
                          ],
                          stops: const [0.0, 0.6, 1.0],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              );
            },
          ),

          // Backdrop Blur Layer for glassmorphic/ambient effect
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 95, sigmaY: 95),
              child: Container(
                color: Colors.transparent,
              ),
            ),
          ),

          // Content Layer
          Positioned.fill(
            child: SafeArea(
              child: widget.child,
            ),
          ),
        ],
      ),
    );
  }
}
