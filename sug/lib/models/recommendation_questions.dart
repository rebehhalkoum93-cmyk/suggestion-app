import '../models/category_theme.dart';
import 'language_settings.dart';

class SurveyOption {
  final String text;
  final String arabicText;
  final Map<String, String> tags;

  const SurveyOption({
    required this.text,
    required this.arabicText,
    required this.tags,
  });

  String get localizedText => LanguageSettings.isArabic ? arabicText : text;
}

class SurveyQuestion {
  final String questionText;
  final String arabicQuestionText;
  final List<SurveyOption> options;

  const SurveyQuestion({
    required this.questionText,
    required this.arabicQuestionText,
    required this.options,
  });

  String get localizedQuestionText => LanguageSettings.isArabic ? arabicQuestionText : questionText;
}

List<SurveyQuestion> getQuestionsFor(CategoryType category) {
  switch (category) {
    case CategoryType.music:
      return const [
        // Q1 — Energy Level
        SurveyQuestion(
          questionText: "What is your current physical energy level?",
          arabicQuestionText: "ما هو مستوى طاقتك الجسدية الحالي؟",
          options: [
            SurveyOption(
              text: "Completely drained (Need a soft landing)",
              arabicText: "منهك تمامًا (أحتاج إلى بداية هادئة ومريحة)",
              tags: {
                "tempo": "low",
                "energy": "low",
                "vibe": "acoustic|ambient",
                "acousticness": "high",
              },
            ),
            SurveyOption(
              text: "Rested, calm, and steady (In the zone)",
              arabicText: "مرتاح، هادئ، ومستقر (في حالة تركيز تامة)",
              tags: {
                "tempo": "medium",
                "energy": "medium",
                "vibe": "lofi|minimal|classical",
                "instrumentalness": "high",
              },
            ),
            SurveyOption(
              text: "Hyped and restless (Ready to move)",
              arabicText: "متحمس ونشيط (جاهز للحركة والنشاط)",
              tags: {
                "tempo": "high",
                "energy": "high",
                "vibe": "dance|electronic|hip-hop",
                "danceability": "high",
              },
            ),
            SurveyOption(
              text: "Frustrated/Anxious (Need a sonic release)",
              arabicText: "محبَط أو قلق (أحتاج إلى تفريغ مشاعري بالموسيقى)",
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
          arabicQuestionText: "اختر الأجواء التي تناسب حالتك المزاجية الحالية:",
          options: [
            SurveyOption(
              text: "A rainy midnight drive through neon-lit streets",
              arabicText: "قيادة هادئة تحت المطر في منتصف الليل وسط أضواء النيون",
              tags: {
                "aesthetic": "synthwave|dreampop|jazz",
                "mood": "melancholic|reflective",
              },
            ),
            SurveyOption(
              text: "A busy, sunlit afternoon coffee shop",
              arabicText: "مقهى مزدحم تملؤه أشعة الشمس الدافئة بعد الظهيرة",
              tags: {
                "aesthetic": "indie|folk|pop",
                "mood": "cheerful|warm",
              },
            ),
            SurveyOption(
              text: "A dark, underground club basement",
              arabicText: "قبو نادي مظلم تحت الأرض يعج بالحيوية والموسيقى",
              tags: {
                "aesthetic": "techno|house|trap",
                "mood": "hypnotic|intense",
              },
            ),
            SurveyOption(
              text: "A peaceful cabin deep in the silent woods",
              arabicText: "كوخ هادئ وناعم في أعماق الغابة الصامتة",
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
          arabicQuestionText: "على ماذا يجب أن تركز الموسيقى بشكل أساسي؟",
          options: [
            SurveyOption(
              text: "Deep, poetic storytelling and lyrics",
              arabicText: "قصص عميقة وكلمات شاعرية معبرة",
              tags: {
                "focus": "vocal_driven",
                "genres": "singer-songwriter|rap|folk",
              },
            ),
            SurveyOption(
              text: "Heavy basslines and hard-hitting beats",
              arabicText: "إيقاعات قوية ونبضات صاخبة",
              tags: {
                "focus": "beat_driven",
                "genres": "edm|hip-hop|rnb",
              },
            ),
            SurveyOption(
              text: "Smooth, atmospheric instrumental waves",
              arabicText: "موجات موسيقية هادئة وخلفية لحنية بدون كلمات",
              tags: {
                "focus": "instrumental",
                "genres": "ambient|post-rock|lofi",
              },
            ),
            SurveyOption(
              text: "Catchy, feel-good, upbeat melodies",
              arabicText: "ألحان مبهجة وسريعة تحسن المزاج وتدعو للسرور",
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
          arabicQuestionText: "ما مدى رغبتك في التواصل الاجتماعي في هذه اللحظة؟",
          options: [
            SurveyOption(
              text: "Deeply introspective (Me, myself, and I)",
              arabicText: "رغبة عميقة في الانعزال (أنا ونفسي فقط)",
              tags: {
                "vibe": "solo|intimate",
                "depth": "deep",
                "mood": "introverted",
              },
            ),
            SurveyOption(
              text: "Warmly nostalgic (Missing old friends or memories)",
              arabicText: "حنين دافئ للماضي (أفتقد الأصدقاء القدامى والذكريات الجميلة)",
              tags: {
                "vibe": "retro|vintage",
                "era": "70s|80s|90s",
                "mood": "nostalgic",
              },
            ),
            SurveyOption(
              text: "Social and collaborative (Ready to party or share)",
              arabicText: "اجتماعي وتفاعلي (مستعد للاحتفال والمشاركة مع الآخرين)",
              tags: {
                "vibe": "crowd-pleaser|hype",
                "mainstream": "high",
                "mood": "extroverted",
              },
            ),
            SurveyOption(
              text: "Rebellious and disconnected (In my own lane)",
              arabicText: "متمرد ومنفصل عن المألوف (أسير في طريقي الخاص)",
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
          arabicQuestionText: "أي حقبة موسيقية تجذبك في الوقت الحالي؟",
          options: [
            SurveyOption(
              text: "Timeless classics (Golden age, vintage warmth)",
              arabicText: "كلاسيكيات خالدة (الزمن الجميل، الدفء القديم)",
              tags: {
                "era": "pre-1980",
                "style": "analog|acoustic|classic",
              },
            ),
            SurveyOption(
              text: "Retro nostalgia (Synth-heavy, early digital grit)",
              arabicText: "نوستالجيا الثمانينات والتسعينات (أنغام كلاسيكية وموسيقى رقمية مبكرة)",
              tags: {
                "era": "1980-2000",
                "style": "synth-pop|grunge|90s-hiphop",
              },
            ),
            SurveyOption(
              text: "Modern landscape (Sleek, current, fresh releases)",
              arabicText: "الموسيقى العصرية الحديثة (إصدارات جديدة وإنتاج حديث ونقي)",
              tags: {
                "era": "2010-present",
                "style": "modern-production|clean",
              },
            ),
            SurveyOption(
              text: "Futuristic / Avant-garde (Experimental, boundary-pushing)",
              arabicText: "مستقبلية وتجريبية (أفكار مبتكرة وخارجة عن المألوف)",
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
          arabicQuestionText: "ما هو الهدف الأساسي من تشغيل الموسيقى الآن؟",
          options: [
            SurveyOption(
              text: "Deep study, coding, or quiet writing",
              arabicText: "دراسة عميقة، برمجة، أو كتابة في جو هادئ",
              tags: {
                "purpose": "focus",
                "vocals": "none|minimal",
                "distraction": "low",
              },
            ),
            SurveyOption(
              text: "Driving, walking, or physical workouts",
              arabicText: "أثناء القيادة، المشي، أو أداء التمارين الرياضية",
              tags: {
                "purpose": "movement",
                "rhythm": "steady|upbeat",
                "drive": "high",
              },
            ),
            SurveyOption(
              text: "Winding down for sleep or meditation",
              arabicText: "الاسترخاء التام للنوم أو التأمل الهادئ",
              tags: {
                "purpose": "sleep|meditate",
                "tempo": "ultra-low",
                "relaxing": "high",
              },
            ),
            SurveyOption(
              text: "Cleaning, cooking, or hosting a casual night",
              arabicText: "ترتيب المنزل، الطبخ، أو استضافة أمسية ودية ممتعة",
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
          arabicQuestionText: "كيف تريد لنبضات قلبك أن تتفاعل مع الموسيقى؟",
          options: [
            SurveyOption(
              text: "Slow down and breathe easily",
              arabicText: "التباطؤ والتنفس بكل هدوء وأريحية",
              tags: {
                "arousal": "low",
                "soothing": "high",
                "dynamics": "flat",
              },
            ),
            SurveyOption(
              text: "Keep a steady, rhythmic pulse",
              arabicText: "الحفاظ على نبض منتظم ومستقر يدعو للتركيز",
              tags: {
                "arousal": "medium",
                "groove": "high",
                "dynamics": "consistent",
              },
            ),
            SurveyOption(
              text: "Skyrocket with high-energy excitement",
              arabicText: "التسارع بجنون مع طاقة وحماس شديدين",
              tags: {
                "arousal": "high",
                "hype": "high",
                "dynamics": "explosive",
              },
            ),
            SurveyOption(
              text: "Go on a wild emotional ride (Big builds and drops)",
              arabicText: "رحلة مشاعر حافلة (تصاعد درامي وهبوط تدريجي مثير)",
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
          arabicQuestionText: "ما هو الهدف النهائي من سهرة الليلة؟",
          options: [
            SurveyOption(
              text: "Pure, mindless escapism and laughs",
              arabicText: "هروب تام من الواقع، وضحك تسلية خفيفة",
              tags: {
                "genre": "comedy|animation",
                "tone": "lighthearted",
                "intensity": "low",
              },
            ),
            SurveyOption(
              text: "A dark, edge-of-your-seat adrenaline rush",
              arabicText: "إثارة وتشويق وحبس أنفاس مليء بالأدرينالين",
              tags: {
                "genre": "thriller|horror|action",
                "tone": "tense",
                "intensity": "high",
              },
            ),
            SurveyOption(
              text: "A deep, mind-bending intellectual puzzle",
              arabicText: "لغز فكري عميق يحتاج إلى التفكير والتحليل",
              tags: {
                "genre": "mystery|sci-fi",
                "tone": "cerebral",
                "plot": "complex",
              },
            ),
            SurveyOption(
              text: "A heavy, cathartic emotional cry",
              arabicText: "فيلم درامي رومانسي مؤثر يثير الدموع والمشاعر",
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
          arabicQuestionText: "ما مدى المجهود الذهني الذي ترغب في بذله أثناء المشاهدة؟",
          options: [
            SurveyOption(
              text: "Zero thoughts, just pure visual vibes and spectacle",
              arabicText: "لا تفكير إطلاقاً، فقط متعة بصرية ومؤثرات مذهلة",
              tags: {
                "complexity": "low",
                "pacing": "fast",
                "visual_style": "blockbusters",
              },
            ),
            SurveyOption(
              text: "Keep me engaged, but don't overcomplicate it",
              arabicText: "أريد الاندماج والتركيز، لكن بدون تعقيدات مفرطة",
              tags: {
                "complexity": "medium",
                "pacing": "balanced",
                "visual_style": "mainstream",
              },
            ),
            SurveyOption(
              text: "I want to actively piece together clues and think",
              arabicText: "أريد البحث عن أدلة والتفكير وحل خيوط الحبكة بنفسي",
              tags: {
                "complexity": "high",
                "pacing": "meticulous",
                "visual_style": "non-linear",
              },
            ),
            SurveyOption(
              text: "Give me philosophical existential dread",
              arabicText: "أريد أفكاراً فلسفية وجودية عميقة تجعلني أتساءل عن الحياة",
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
          arabicQuestionText: "ما نوع العالم الذي تريد الانغماس فيه؟",
          options: [
            SurveyOption(
              text: "Gritty, realistic, and street-level",
              arabicText: "عالم واقعي وصادق يعبر عن قسوة الحياة الواقعية والأحياء الشعبية",
              tags: {
                "setting": "contemporary|urban",
                "style": "realism|neo-noir",
              },
            ),
            SurveyOption(
              text: "Magical, epic, or high-concept sci-fi",
              arabicText: "عالم خيالي أو علمي ساحر مليء بالابتكار والإثارة الملحمية",
              tags: {
                "setting": "futuristic|fantasy",
                "style": "world-building",
              },
            ),
            SurveyOption(
              text: "Glamorous, high-society, or historical past",
              arabicText: "عالم كلاسيكي تاريخي أو مجتمعات راقية من الماضي الجميل",
              tags: {
                "setting": "period_piece|historical",
                "style": "stylized",
              },
            ),
            SurveyOption(
              text: "Cozy, relatable, and everyday life",
              arabicText: "حياة يومية هادئة ودافئة قريبة من القلب تشعرك بالراحة",
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
          arabicQuestionText: "ما هو شعورك تجاه التوتر والغموض والتشويق الليلة؟",
          options: [
            SurveyOption(
              text: "Keep it entirely stress-free and safe",
              arabicText: "أريده خالياً من التوتر تماماً وآمناً ومريحاً للأعصاب",
              tags: {
                "suspense": "none",
                "threat_level": "low",
                "vibe": "wholesome",
              },
            ),
            SurveyOption(
              text: "Mild tension with a guaranteed happy resolution",
              arabicText: "توتر خفيف ولطيف ينتهي بنهاية سعيدة ومضمونة",
              tags: {
                "suspense": "low",
                "threat_level": "medium",
                "vibe": "satisfying",
              },
            ),
            SurveyOption(
              text: "High suspense, constant danger, and real stakes",
              arabicText: "تشويق وإثارة مستمرين وخطر يحيط بالشخصيات من كل جانب",
              tags: {
                "suspense": "high",
                "threat_level": "high",
                "vibe": "intense",
              },
            ),
            SurveyOption(
              text: "Psychological terror (Mess with my mind)",
              arabicText: "رعب نفسي يثير الذهن ويلعب بالخيال والمشاعر الدفينة",
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
          arabicQuestionText: "أي فترة زمنية من صناعة السينما تناسب مزاجك الآن؟",
          options: [
            SurveyOption(
              text: "Modern Blockbuster (Clean CGI, modern dialogue)",
              arabicText: "أفلام حديثة كبرى (مؤثرات بصرية نقية وحوار معاصر)",
              tags: {
                "era": "2015-present",
                "production": "modern-high",
              },
            ),
            SurveyOption(
              text: "Retro Classic (The 90s and 2000s sweet spot)",
              arabicText: "كلاسيكيات التسعينات والألفينات الدافئة (المرحلة الذهبية لسينما العصر الذهبي القريب)",
              tags: {
                "era": "1990-2015",
                "production": "practical-heavy",
              },
            ),
            SurveyOption(
              text: "Nostalgic Vintage (Old Hollywood, retro film grain)",
              arabicText: "زمن هوليوود القديم (ألوان عتيقة، موسيقى كلاسيكية وملمس سينمائي)",
              tags: {
                "era": "pre-1990",
                "production": "classic",
              },
            ),
            SurveyOption(
              text: "Indie / Art-house (Unique cinematography, not budget)",
              arabicText: "أفلام مستقلة وفنية (تركيز كامل على الفن والقصة والسينماتوغرافيا المبتكرة)",
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
          arabicQuestionText: "من يشاهد هذا الفيلم معك الليلة؟",
          options: [
            SurveyOption(
              text: "Just me (Deeply personal, introspective stories)",
              arabicText: "أنا بمفردي (أفضل قصة شخصية عميقة ومؤثرة)",
              tags: {
                "audience": "solo",
                "themes": "introspective|character-study",
              },
            ),
            SurveyOption(
              text: "Date night (Romance, chemistry, tension)",
              arabicText: "سهرة رومانسية (أجواء مشاعر وكيمياء مميزة وتناغم)",
              tags: {
                "audience": "romantic-partner",
                "themes": "romantic|tension|chemistry",
              },
            ),
            SurveyOption(
              text: "Friends or roommates (Crowd-pleaser, fun for all)",
              arabicText: "الأصدقاء أو زملاء السكن (فيلم ممتع، مسلٍ ومناسب للنقاش)",
              tags: {
                "audience": "group",
                "themes": "interactive|fun|entertaining",
              },
            ),
            SurveyOption(
              text: "Family night (Safe for all generations)",
              arabicText: "العائلة (فيلم مناسب وآمن لجميع الفئات والأعمار المختلفة)",
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
          arabicQuestionText: "ما هي وتيرة وتدفق سرد القصة التي تفضلها؟",
          options: [
            SurveyOption(
              text: "Fast & Furious (Non-stop action, rapid cuts)",
              arabicText: "سريع وحماسي (أحداث متلاحقة وإثارة مستمرة بدون توقف)",
              tags: {
                "pacing": "hyper_fast",
                "storytelling": "action_led",
              },
            ),
            SurveyOption(
              text: "Smooth & Steady (Classic 3-act, easy flow)",
              arabicText: "معتدل ومستقر (حبكة كلاسيكية منظمة وتدفق سهل)",
              tags: {
                "pacing": "balanced",
                "storytelling": "conventional",
              },
            ),
            SurveyOption(
              text: "Slow Burn (Atmospheric, quiet moments, rewarding climax)",
              arabicText: "بناء بطيء وهادئ (أجواء سينمائية عميقة ونهاية حاسمة مستحقة)",
              tags: {
                "pacing": "slow_burn",
                "storytelling": "character_led",
              },
            ),
            SurveyOption(
              text: "Artistic & Dreamlike (Abstract, poetic, visual-centric)",
              arabicText: "فني وشاعري (أفكار تجريدية وحبكة غير تقليدية وتعبير بصري خلاق)",
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
          arabicQuestionText: "ما هو الوقت ومدى الالتزام الذي ترغب في تخصيصه للمسلسل؟",
          options: [
            SurveyOption(
              text: "Fast, self-contained episodic laughs (Sitcom style)",
              arabicText: "حلقات قصيرة كوميدية منفصلة ومضحكة (كوميديا الموقف)",
              tags: {
                "format": "sitcom",
                "runtime": "20-30m",
                "serialized": "low",
              },
            ),
            SurveyOption(
              text: "A short, high-intensity limited series (One-and-done)",
              arabicText: "مسلسل قصير مكثف ومترابط الأحداث ينتهي في موسم واحد",
              tags: {
                "format": "limited_series",
                "runtime": "45-60m",
                "serialized": "high",
              },
            ),
            SurveyOption(
              text: "A massive, multi-season universe to get lost in",
              arabicText: "عالم شاسع ممتد لعدة مواسم متتالية تندمج فيه تماماً",
              tags: {
                "format": "multi_season",
                "seasons": ">3",
                "serialized": "high",
              },
            ),
            SurveyOption(
              text: "Cozy background viewing (Low-stakes, episodic comfort)",
              arabicText: "مسلسل مريح للمشاهدة الجانبية الهادئة (وتيرة خفيفة ومسلية)",
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
          arabicQuestionText: "ما هو عامل الجذب الأساسي الذي تبحث عنه في القصة؟",
          options: [
            SurveyOption(
              text: "Non-stop cliffhangers and shocking twists",
              arabicText: "أحداث تنتهي بمقاطع مشوقة ومفاجآت غير متوقعة تصدمك باستمرار",
              tags: {
                "hook": "cliffhanger",
                "pacing": "hyper_fast",
                "subgenre": "mystery|conspiracy",
              },
            ),
            SurveyOption(
              text: "Quick-witted, hilarious character banter",
              arabicText: "حوارات ذكية ومضحكة بين الشخصيات تفيض بالحيوية والطرافة",
              tags: {
                "hook": "dialogue",
                "pacing": "fast",
                "subgenre": "sitcom|dramedy",
              },
            ),
            SurveyOption(
              text: "Complex political intrigue and power struggles",
              arabicText: "مؤامرات سياسية معقدة وصراعات حادة على السلطة والملك",
              tags: {
                "hook": "world_politics",
                "pacing": "steady",
                "subgenre": "historical|fantasy_politics",
              },
            ),
            SurveyOption(
              text: "Deep, slow-burn psychological character studies",
              arabicText: "دراسة وتطور نفسي بطيء وعميق لشخصيات القصة وعوالمها الداخلية",
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
          arabicQuestionText: "كيف تحب أن تشعر عندما تكتمل القصة وتنتهي الحلقة الأخيرة؟",
          options: [
            SurveyOption(
              text: "Stunned, staring at the wall questioning reality",
              arabicText: "مذهول وصامت، أتساءل عما حدث وأعيد حساباتي",
              tags: {
                "ending": "twist|ambiguous",
                "resolution": "open_ended",
              },
            ),
            SurveyOption(
              text: "Warm, happy, and fully comforted",
              arabicText: "سعيد، دافئ ومكتفٍ تماماً بنهاية مرضية ومبهجة",
              tags: {
                "ending": "uplifting|resolved",
                "resolution": "happy_ending",
              },
            ),
            SurveyOption(
              text: "Empowered, motivated, and inspired",
              arabicText: "قوي وملهم وممتلئ بالحماسة والطاقة الإيجابية",
              tags: {
                "ending": "triumphant",
                "resolution": "inspiring",
              },
            ),
            SurveyOption(
              text: "Hauntingly reflective and bittersweet",
              arabicText: "متأثر وعاطفي، بمزيج من الحزن الجميل والتأمل العميق",
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
          arabicQuestionText: "ما هو مدى استعدادك لمتابعة قضايا ومواضيع سوداوية عميقة؟",
          options: [
            SurveyOption(
              text: "Light, bright, and purely optimistic",
              arabicText: "خفيف ومشرق ومتفائل تماماً يبعث على الراحة والسرور",
              tags: {
                "tone": "light",
                "themes": "optimistic|wholesome",
                "intensity": "low",
              },
            ),
            SurveyOption(
              text: "Realist (Life has ups and downs, mostly hopeful)",
              arabicText: "واقعي (يرصد تقلبات الحياة بحلوها ومرها، مع طابع يبعث على الأمل)",
              tags: {
                "tone": "realistic",
                "themes": "balanced",
                "intensity": "medium",
              },
            ),
            SurveyOption(
              text: "Gritty, cynical, and morally grey",
              arabicText: "شخصيات ذات دوافع معقدة وعالم يسوده الغموض والصراع الأخلاقي",
              tags: {
                "tone": "dark",
                "themes": "moral-ambiguity",
                "intensity": "high",
              },
            ),
            SurveyOption(
              text: "Pitch black (Grim, psychological, no easy ways out)",
              arabicText: "سوداوي جداً (عالم قاسٍ، رعب نفسي وصراعات مصيرية بدون مخرج سهل)",
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
          arabicQuestionText: "ما هي طبيعة العلاقات والروابط المفضلة لديك بين أبطال العمل؟",
          options: [
            SurveyOption(
              text: "Ensemble cast of quirky, lovable friends",
              arabicText: "مجموعة أصدقاء ظرفاء، تجمعهم مواقف محببة وروح تفاعلية دافئة",
              tags: {
                "characters": "ensemble",
                "vibe": "found_family|friendship",
              },
            ),
            SurveyOption(
              text: "One iconic, powerful lead carrying the show",
              arabicText: "بطل واحد رئيسي مميز وجذاب يقود الأحداث ورحلة المسلسل بمفرده",
              tags: {
                "characters": "solo-lead",
                "vibe": "hero-journey|antihero",
              },
            ),
            SurveyOption(
              text: "A fierce rivalry / Cat-and-mouse chase",
              arabicText: "صراع حاد ومطاردة مثيرة أشبه بلعبة القط والفأر والمواجهات الثنائية",
              tags: {
                "characters": "duel",
                "vibe": "psychological-rivalry|crime-chase",
              },
            ),
            SurveyOption(
              text: "Interweaving, multi-perspective timelines",
              arabicText: "قصص متعددة المسارات وأزمنة متداخلة تنسج لوحة درامية واسعة النطاق",
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
          arabicQuestionText: "كيف تحب أن تبدو الصورة والتصميم الفني والجماليات البصرية للمسلسل؟",
          options: [
            SurveyOption(
              text: "Clean, modern, bright, and high-budget",
              arabicText: "نقي، عصري، ساطع الإضاءة مع إنتاج فخم عالي الجودة وممتاز",
              tags: {
                "visuals": "clean|hd",
                "color_palette": "bright",
                "budget": "high",
              },
            ),
            SurveyOption(
              text: "Moody, shadow-filled, dramatic, and artistic",
              arabicText: "أجواء سينمائية غامرة بالظلال والدراما الفنية والتصوير المبتكر",
              tags: {
                "visuals": "cinematic|shadowy",
                "color_palette": "dark|muted",
                "budget": "medium-high",
              },
            ),
            SurveyOption(
              text: "Vintage, nostalgic, retro-graded film look",
              arabicText: "طابع سينمائي قديم دافئ يثير نوستالجيا الزمن الماضي والألوان الغنية",
              tags: {
                "visuals": "retro|stylized",
                "color_palette": "warm|saturated",
              },
            ),
            SurveyOption(
              text: "Surreal, abstract, animated, or highly stylized",
              arabicText: "رسوم متحركة مبتكرة أو عالم تجريدي خيالي غريب وغير مألوف",
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
          arabicQuestionText: "ما هي درجة عمق وتفاصيل تصميم العالم الذي تفضلها؟",
          options: [
            SurveyOption(
              text: "None (Set in our normal, everyday world)",
              arabicText: "عالم واقعي تماماً يشابه واقعنا وحياتنا اليومية البسيطة",
              tags: {
                "setting": "present_day",
                "world_building": "zero",
              },
            ),
            SurveyOption(
              text: "Light Twist (Our world, but with one secret difference)",
              arabicText: "عالمنا المألوف لكن مع لمسة غموض أو سر خفي واحد يميزه",
              tags: {
                "setting": "magical_realism|subtle_scifi",
                "world_building": "light",
              },
            ),
            SurveyOption(
              text: "Elaborate History (Period pieces, real events, massive sets)",
              arabicText: "أحداث تاريخية ملحمية مستوحاة من الماضي بمواقع وديكورات ضخمة ومقنعة",
              tags: {
                "setting": "historical",
                "world_building": "medium",
              },
            ),
            SurveyOption(
              text: "Total Fantasy/Sci-Fi (New rules, maps, tech, languages)",
              arabicText: "خيال علمي وفانتازيا كاملة بقوانين جديدة، خرائط، لغات وتكنولوجيا متقدمة",
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
