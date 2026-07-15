import '../models/category_theme.dart';

class SurveyOption {
  final String text;
  final Map<String, String> tags;

  const SurveyOption({
    required this.text,
    required this.tags,
  });
}

class SurveyQuestion {
  final String questionText;
  final List<SurveyOption> options;

  const SurveyQuestion({
    required this.questionText,
    required this.options,
  });
}

List<SurveyQuestion> getQuestionsFor(CategoryType category) {
  switch (category) {
    case CategoryType.music:
      return const [
        // Q1 — Energy Level
        SurveyQuestion(
          questionText: "What is your current physical energy level?",
          options: [
            SurveyOption(
              text: "Completely drained (Need a soft landing)",
              tags: {
                "tempo": "low",
                "energy": "low",
                "vibe": "acoustic|ambient",
                "acousticness": "high",
              },
            ),
            SurveyOption(
              text: "Rested, calm, and steady (In the zone)",
              tags: {
                "tempo": "medium",
                "energy": "medium",
                "vibe": "lofi|minimal|classical",
                "instrumentalness": "high",
              },
            ),
            SurveyOption(
              text: "Hyped and restless (Ready to move)",
              tags: {
                "tempo": "high",
                "energy": "high",
                "vibe": "dance|electronic|hip-hop",
                "danceability": "high",
              },
            ),
            SurveyOption(
              text: "Frustrated/Anxious (Need a sonic release)",
              tags: {
                "tempo": "high|medium",
                "energy": "high",
                "vibe": "rock|metal|punk|grunge",
                "loudness": "high",
              },
            ),
          ],
        ),
        // Q2 — Environment
        SurveyQuestion(
          questionText: "Pick an environment that matches your headspace:",
          options: [
            SurveyOption(
              text: "A rainy midnight drive through neon-lit streets",
              tags: {
                "aesthetic": "synthwave|dreampop|jazz",
                "mood": "melancholic|reflective",
              },
            ),
            SurveyOption(
              text: "A busy, sunlit afternoon coffee shop",
              tags: {
                "aesthetic": "indie|folk|pop",
                "mood": "cheerful|warm",
              },
            ),
            SurveyOption(
              text: "A dark, underground club basement",
              tags: {
                "aesthetic": "techno|house|trap",
                "mood": "hypnotic|intense",
              },
            ),
            SurveyOption(
              text: "A peaceful cabin deep in the silent woods",
              tags: {
                "aesthetic": "folk|neo-classical|ambient",
                "mood": "serene|isolated",
              },
            ),
          ],
        ),
        // Q3 — Focus
        SurveyQuestion(
          questionText: "What should the music primarily focus on?",
          options: [
            SurveyOption(
              text: "Deep, poetic storytelling and lyrics",
              tags: {
                "focus": "vocal_driven",
                "genres": "singer-songwriter|rap|folk",
              },
            ),
            SurveyOption(
              text: "Heavy basslines and hard-hitting beats",
              tags: {
                "focus": "beat_driven",
                "genres": "edm|hip-hop|rnb",
              },
            ),
            SurveyOption(
              text: "Smooth, atmospheric instrumental waves",
              tags: {
                "focus": "instrumental",
                "genres": "ambient|post-rock|lofi",
              },
            ),
            SurveyOption(
              text: "Catchy, feel-good, upbeat melodies",
              tags: {
                "focus": "melody_driven",
                "genres": "pop|funk|disco",
              },
            ),
          ],
        ),
        // Q4 — Social connectedness
        SurveyQuestion(
          questionText: "How socially connected do you feel right now?",
          options: [
            SurveyOption(
              text: "Deeply introspective (Me, myself, and I)",
              tags: {
                "vibe": "solo|intimate",
                "depth": "deep",
                "mood": "introverted",
              },
            ),
            SurveyOption(
              text: "Warmly nostalgic (Missing old friends or memories)",
              tags: {
                "vibe": "retro|vintage",
                "era": "70s|80s|90s",
                "mood": "nostalgic",
              },
            ),
            SurveyOption(
              text: "Social and collaborative (Ready to party or share)",
              tags: {
                "vibe": "crowd-pleaser|hype",
                "mainstream": "high",
                "mood": "extroverted",
              },
            ),
            SurveyOption(
              text: "Rebellious and disconnected (In my own lane)",
              tags: {
                "vibe": "alternative|indie",
                "underground": "high",
                "mood": "edgy",
              },
            ),
          ],
        ),
        // Q5 — Era
        SurveyQuestion(
          questionText: "What era of music sounds appealing right now?",
          options: [
            SurveyOption(
              text: "Timeless classics (Golden age, vintage warmth)",
              tags: {
                "era": "pre-1980",
                "style": "analog|acoustic|classic",
              },
            ),
            SurveyOption(
              text: "Retro nostalgia (Synth-heavy, early digital grit)",
              tags: {
                "era": "1980-2000",
                "style": "synth-pop|grunge|90s-hiphop",
              },
            ),
            SurveyOption(
              text: "Modern landscape (Sleek, current, fresh releases)",
              tags: {
                "era": "2010-present",
                "style": "modern-production|clean",
              },
            ),
            SurveyOption(
              text: "Futuristic / Avant-garde (Experimental, boundary-pushing)",
              tags: {
                "era": "avant-garde",
                "style": "experimental|hyperpop|idm",
              },
            ),
          ],
        ),
        // Q6 — Purpose
        SurveyQuestion(
          questionText: "What is the primary purpose of playing this music?",
          options: [
            SurveyOption(
              text: "Deep study, coding, or quiet writing",
              tags: {
                "purpose": "focus",
                "vocals": "none|minimal",
                "distraction": "low",
              },
            ),
            SurveyOption(
              text: "Driving, walking, or physical workouts",
              tags: {
                "purpose": "movement",
                "rhythm": "steady|upbeat",
                "drive": "high",
              },
            ),
            SurveyOption(
              text: "Winding down for sleep or meditation",
              tags: {
                "purpose": "sleep|meditate",
                "tempo": "ultra-low",
                "relaxing": "high",
              },
            ),
            SurveyOption(
              text: "Cleaning, cooking, or hosting a casual night",
              tags: {
                "purpose": "background_hype",
                "tempo": "medium-high",
                "feel-good": "high",
              },
            ),
          ],
        ),
        // Q7 — Heart Rate
        SurveyQuestion(
          questionText: "How do you want your heart rate to respond?",
          options: [
            SurveyOption(
              text: "Slow down and breathe easily",
              tags: {
                "arousal": "low",
                "soothing": "high",
                "dynamics": "flat",
              },
            ),
            SurveyOption(
              text: "Keep a steady, rhythmic pulse",
              tags: {
                "arousal": "medium",
                "groove": "high",
                "dynamics": "consistent",
              },
            ),
            SurveyOption(
              text: "Skyrocket with high-energy excitement",
              tags: {
                "arousal": "high",
                "hype": "high",
                "dynamics": "explosive",
              },
            ),
            SurveyOption(
              text: "Go on a wild emotional ride (Big builds and drops)",
              tags: {
                "arousal": "variable",
                "cinematic": "high",
                "dynamics": "wide",
              },
            ),
          ],
        ),
      ];

    case CategoryType.movie:
      return const [
        // Q1 — Goal
        SurveyQuestion(
          questionText: "What is the ultimate goal of this movie night?",
          options: [
            SurveyOption(
              text: "Pure, mindless escapism and laughs",
              tags: {
                "genre": "comedy|animation",
                "tone": "lighthearted",
                "intensity": "low",
              },
            ),
            SurveyOption(
              text: "A dark, edge-of-your-seat adrenaline rush",
              tags: {
                "genre": "thriller|horror|action",
                "tone": "tense",
                "intensity": "high",
              },
            ),
            SurveyOption(
              text: "A deep, mind-bending intellectual puzzle",
              tags: {
                "genre": "mystery|sci-fi",
                "tone": "cerebral",
                "plot": "complex",
              },
            ),
            SurveyOption(
              text: "A heavy, cathartic emotional cry",
              tags: {
                "genre": "drama|romance",
                "tone": "emotional",
                "intensity": "medium",
              },
            ),
          ],
        ),
        // Q2 — Brainpower
        SurveyQuestion(
          questionText: "How much brainpower do you want to invest?",
          options: [
            SurveyOption(
              text: "Zero thoughts, just pure visual vibes and spectacle",
              tags: {
                "complexity": "low",
                "pacing": "fast",
                "visual_style": "blockbusters",
              },
            ),
            SurveyOption(
              text: "Keep me engaged, but don't overcomplicate it",
              tags: {
                "complexity": "medium",
                "pacing": "balanced",
                "visual_style": "mainstream",
              },
            ),
            SurveyOption(
              text: "I want to actively piece together clues and think",
              tags: {
                "complexity": "high",
                "pacing": "meticulous",
                "visual_style": "non-linear",
              },
            ),
            SurveyOption(
              text: "Give me philosophical existential dread",
              tags: {
                "complexity": "high",
                "tone": "bleak|philosophical",
                "themes": "existential",
              },
            ),
          ],
        ),
        // Q3 — World
        SurveyQuestion(
          questionText: "What kind of world do you want to step into?",
          options: [
            SurveyOption(
              text: "Gritty, realistic, and street-level",
              tags: {
                "setting": "contemporary|urban",
                "style": "realism|neo-noir",
              },
            ),
            SurveyOption(
              text: "Magical, epic, or high-concept sci-fi",
              tags: {
                "setting": "futuristic|fantasy",
                "style": "world-building",
              },
            ),
            SurveyOption(
              text: "Glamorous, high-society, or historical past",
              tags: {
                "setting": "period_piece|historical",
                "style": "stylized",
              },
            ),
            SurveyOption(
              text: "Cozy, relatable, and everyday life",
              tags: {
                "setting": "suburban|small_town",
                "style": "slice_of_life",
              },
            ),
          ],
        ),
        // Q4 — Suspense
        SurveyQuestion(
          questionText: "How do you feel about tension and suspense?",
          options: [
            SurveyOption(
              text: "Keep it entirely stress-free and safe",
              tags: {
                "suspense": "none",
                "threat_level": "low",
                "vibe": "wholesome",
              },
            ),
            SurveyOption(
              text: "Mild tension with a guaranteed happy resolution",
              tags: {
                "suspense": "low",
                "threat_level": "medium",
                "vibe": "satisfying",
              },
            ),
            SurveyOption(
              text: "High suspense, constant danger, and real stakes",
              tags: {
                "suspense": "high",
                "threat_level": "high",
                "vibe": "intense",
              },
            ),
            SurveyOption(
              text: "Psychological terror (Mess with my mind)",
              tags: {
                "suspense": "extreme",
                "threat_level": "psychological",
                "vibe": "disturbing",
              },
            ),
          ],
        ),
        // Q5 — Era
        SurveyQuestion(
          questionText: "What era of filmmaking fits your mood?",
          options: [
            SurveyOption(
              text: "Modern Blockbuster (Clean CGI, modern dialogue)",
              tags: {
                "era": "2015-present",
                "production": "modern-high",
              },
            ),
            SurveyOption(
              text: "Retro Classic (The 90s and 2000s sweet spot)",
              tags: {
                "era": "1990-2015",
                "production": "practical-heavy",
              },
            ),
            SurveyOption(
              text: "Nostalgic Vintage (Old Hollywood, raw film grain)",
              tags: {
                "era": "pre-1990",
                "production": "classic",
              },
            ),
            SurveyOption(
              text: "Indie / Art-house (Unique cinematography, not budget)",
              tags: {
                "era": "any",
                "production": "indie|low-budget",
                "focus": "artistic",
              },
            ),
          ],
        ),
        // Q6 — Audience
        SurveyQuestion(
          questionText: "Who is watching this movie with you?",
          options: [
            SurveyOption(
              text: "Just me (Deeply personal, introspective stories)",
              tags: {
                "audience": "solo",
                "themes": "introspective|character-study",
              },
            ),
            SurveyOption(
              text: "Date night (Romance, chemistry, tension)",
              tags: {
                "audience": "romantic-partner",
                "themes": "romantic|tension|chemistry",
              },
            ),
            SurveyOption(
              text: "Friends or roommates (Crowd-pleaser, fun for all)",
              tags: {
                "audience": "group",
                "themes": "interactive|fun|entertaining",
              },
            ),
            SurveyOption(
              text: "Family night (Safe for all generations)",
              tags: {
                "audience": "family",
                "rating": "PG|G",
                "themes": "broad-appeal",
              },
            ),
          ],
        ),
        // Q7 — Pacing
        SurveyQuestion(
          questionText: "How do you want the story pacing to feel?",
          options: [
            SurveyOption(
              text: "Fast & Furious (Non-stop action, rapid cuts)",
              tags: {
                "pacing": "hyper_fast",
                "storytelling": "action_led",
              },
            ),
            SurveyOption(
              text: "Smooth & Steady (Classic 3-act, easy flow)",
              tags: {
                "pacing": "balanced",
                "storytelling": "conventional",
              },
            ),
            SurveyOption(
              text: "Slow Burn (Atmospheric, quiet moments, rewarding climax)",
              tags: {
                "pacing": "slow_burn",
                "storytelling": "character_led",
              },
            ),
            SurveyOption(
              text: "Artistic & Dreamlike (Abstract, poetic, visual-centric)",
              tags: {
                "pacing": "fluid|abstract",
                "storytelling": "non-linear",
              },
            ),
          ],
        ),
      ];

    case CategoryType.series:
      return const [
        // Q1 — Commitment
        SurveyQuestion(
          questionText: "What kind of time commitment are you looking for?",
          options: [
            SurveyOption(
              text: "Fast, self-contained episodic laughs (Sitcom style)",
              tags: {
                "format": "sitcom",
                "runtime": "20-30m",
                "serialized": "low",
              },
            ),
            SurveyOption(
              text: "A short, high-intensity limited series (One-and-done)",
              tags: {
                "format": "limited_series",
                "runtime": "45-60m",
                "serialized": "high",
              },
            ),
            SurveyOption(
              text: "A massive, multi-season universe to get lost in",
              tags: {
                "format": "multi_season",
                "seasons": ">3",
                "serialized": "high",
              },
            ),
            SurveyOption(
              text: "Cozy background viewing (Low-stakes, episodic comfort)",
              tags: {
                "format": "episodic|reality",
                "tone": "low_stakes",
                "comfort_watch": "true",
              },
            ),
          ],
        ),
        // Q2 — Hook
        SurveyQuestion(
          questionText: "What is the primary hook you need right now?",
          options: [
            SurveyOption(
              text: "Non-stop cliffhangers and shocking twists",
              tags: {
                "hook": "cliffhanger",
                "pacing": "hyper_fast",
                "subgenre": "mystery|conspiracy",
              },
            ),
            SurveyOption(
              text: "Quick-witted, hilarious character banter",
              tags: {
                "hook": "dialogue",
                "pacing": "fast",
                "subgenre": "sitcom|dramedy",
              },
            ),
            SurveyOption(
              text: "Complex political intrigue and power struggles",
              tags: {
                "hook": "world_politics",
                "pacing": "steady",
                "subgenre": "historical|fantasy_politics",
              },
            ),
            SurveyOption(
              text: "Deep, slow-burn psychological character studies",
              tags: {
                "hook": "character_arc",
                "pacing": "slow_burn",
                "subgenre": "psychological_drama",
              },
            ),
          ],
        ),
        // Q3 — Ending feel
        SurveyQuestion(
          questionText: "How do you want to feel when the final credits roll?",
          options: [
            SurveyOption(
              text: "Stunned, staring at the wall questioning reality",
              tags: {
                "ending": "twist|ambiguous",
                "resolution": "open_ended",
              },
            ),
            SurveyOption(
              text: "Warm, happy, and fully comforted",
              tags: {
                "ending": "uplifting|resolved",
                "resolution": "happy_ending",
              },
            ),
            SurveyOption(
              text: "Empowered, motivated, and inspired",
              tags: {
                "ending": "triumphant",
                "resolution": "inspiring",
              },
            ),
            SurveyOption(
              text: "Hauntingly reflective and bittersweet",
              tags: {
                "ending": "bittersweet|tragic",
                "resolution": "emotional",
              },
            ),
          ],
        ),
        // Q4 — Darkness threshold
        SurveyQuestion(
          questionText: "How dark are you willing to go with themes?",
          options: [
            SurveyOption(
              text: "Light, bright, and purely optimistic",
              tags: {
                "tone": "light",
                "themes": "optimistic|wholesome",
                "intensity": "low",
              },
            ),
            SurveyOption(
              text: "Realist (Life has ups and downs, mostly hopeful)",
              tags: {
                "tone": "realistic",
                "themes": "balanced",
                "intensity": "medium",
              },
            ),
            SurveyOption(
              text: "Gritty, cynical, and morally grey",
              tags: {
                "tone": "dark",
                "themes": "moral-ambiguity",
                "intensity": "high",
              },
            ),
            SurveyOption(
              text: "Pitch black (Grim, psychological, no easy ways out)",
              tags: {
                "tone": "grimdark",
                "themes": "survival|terror",
                "intensity": "extreme",
              },
            ),
          ],
        ),
        // Q5 — Character dynamic
        SurveyQuestion(
          questionText: "What is your ideal character dynamic?",
          options: [
            SurveyOption(
              text: "Ensemble cast of quirky, lovable friends",
              tags: {
                "characters": "ensemble",
                "vibe": "found_family|friendship",
              },
            ),
            SurveyOption(
              text: "One iconic, powerful lead carrying the show",
              tags: {
                "characters": "solo-lead",
                "vibe": "hero-journey|antihero",
              },
            ),
            SurveyOption(
              text: "A fierce rivalry / Cat-and-mouse chase",
              tags: {
                "characters": "duel",
                "vibe": "psychological-rivalry|crime-chase",
              },
            ),
            SurveyOption(
              text: "Interweaving, multi-perspective timelines",
              tags: {
                "characters": "sprawling",
                "vibe": "family-saga|political-dynasty",
              },
            ),
          ],
        ),
        // Q6 — Visuals
        SurveyQuestion(
          questionText: "What should the visual design of the show look like?",
          options: [
            SurveyOption(
              text: "Clean, modern, bright, and high-budget",
              tags: {
                "visuals": "clean|hd",
                "color_palette": "bright",
                "budget": "high",
              },
            ),
            SurveyOption(
              text: "Moody, shadow-filled, dramatic, and artistic",
              tags: {
                "visuals": "cinematic|shadowy",
                "color_palette": "dark|muted",
                "budget": "medium-high",
              },
            ),
            SurveyOption(
              text: "Vintage, nostalgic, retro-graded film look",
              tags: {
                "visuals": "retro|stylized",
                "color_palette": "warm|saturated",
              },
            ),
            SurveyOption(
              text: "Surreal, abstract, animated, or highly stylized",
              tags: {
                "visuals": "animated|surreal",
                "color_palette": "vibrant",
              },
            ),
          ],
        ),
        // Q7 — World-building
        SurveyQuestion(
          questionText: "What level of world-building depth do you want?",
          options: [
            SurveyOption(
              text: "None (Set in our normal, everyday world)",
              tags: {
                "setting": "present_day",
                "world_building": "zero",
              },
            ),
            SurveyOption(
              text: "Light Twist (Our world, but with one secret difference)",
              tags: {
                "setting": "magical_realism|subtle_scifi",
                "world_building": "light",
              },
            ),
            SurveyOption(
              text: "Elaborate History (Period pieces, real events, massive sets)",
              tags: {
                "setting": "historical",
                "world_building": "medium",
              },
            ),
            SurveyOption(
              text: "Total Fantasy/Sci-Fi (New rules, maps, tech, languages)",
              tags: {
                "setting": "high_fantasy|space_opera",
                "world_building": "extreme",
              },
            ),
          ],
        ),
      ];
  }
}

Map<String, String> getAggregatedTags(CategoryType category, List<int> answers) {
  final questions = getQuestionsFor(category);
  final Map<String, String> aggregated = {};
  for (int i = 0; i < answers.length; i++) {
    if (i < questions.length) {
      final selectedOptionIndex = answers[i];
      if (selectedOptionIndex >= 0 && selectedOptionIndex < questions[i].options.length) {
        aggregated.addAll(questions[i].options[selectedOptionIndex].tags);
      }
    }
  }
  return aggregated;
}
