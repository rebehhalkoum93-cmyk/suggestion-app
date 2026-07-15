# Comprehensive Media Questionnaire & Metadata Tag Mapping

This document contains highly optimized, 7-question survey tracks for **Music**, **Movies**, and **TV Series**. Each question contains 4 specific options mapped to distinct backend metadata tags to ensure maximum accuracy when calling the Gemini API.

---

## 1. 🎵 Music Recommendation Flow (7 Questions)

### Question 1: What is your current physical energy level?
*Focus: Tempo and Rhythm tracking.*
* **A. Completely drained (Need a soft landing)**
    * *Backend Tags:* `tempo: low`, `energy: low`, `vibe: acoustic|ambient`, `acousticness: high`
* **B. Rested, calm, and steady (In the zone)**
    * *Backend Tags:* `tempo: medium`, `energy: medium`, `vibe: lofi|minimal|classical`, `instrumentalness: high`
* **C. Hyped and restless (Ready to move)**
    * *Backend Tags:* `tempo: high`, `energy: high`, `vibe: dance|electronic|hip-hop`, `danceability: high`
* **D. Frustrated/Anxious (Need a sonic release)**
    * *Backend Tags:* `tempo: high|medium`, `energy: high`, `vibe: rock|metal|punk|grunge`, `loudness: high`

### Question 2: Pick an environment that matches your headspace:
*Focus: Ambient texture and tone.*
* **A. A rainy midnight drive through neon-lit streets**
    * *Backend Tags:* `aesthetic: synthwave|dreampop|jazz`, `mood: melancholic|reflective`
* **B. A busy, sunlit afternoon coffee shop**
    * *Backend Tags:* `aesthetic: indie|folk|pop`, `mood: cheerful|warm`
* **C. A dark, underground club basement**
    * *Backend Tags:* `aesthetic: techno|house|trap`, `mood: hypnotic|intense`
* **D. A peaceful cabin deep in the silent woods**
    * *Backend Tags:* `aesthetic: folk|neo-classical|ambient`, `mood: serene|isolated`

### Question 3: What should the music primarily focus on?
*Focus: Primary audio characteristics.*
* **A. Deep, poetic storytelling and lyrics**
    * *Backend Tags:* `focus: vocal_driven`, `genres: singer-songwriter|rap|folk`
* **B. Heavy basslines and hard-hitting beats**
    * *Backend Tags:* `focus: beat_driven`, `genres: edm|hip-hop|rnb`
* **C. Smooth, atmospheric instrumental waves**
    * *Backend Tags:* `focus: instrumental`, `genres: ambient|post-rock|lofi`
* **D. Catchy, feel-good, upbeat melodies**
    * *Backend Tags:* `focus: melody_driven`, `genres: pop|funk|disco`

### Question 4: How socially connected do you feel right now?
*Focus: Intimacy and community vibe.*
* **A. Deeply introspective (Me, myself, and I)**
    * *Backend Tags:* `vibe: solo|intimate`, `depth: deep`, `mood: introverted`
* **B. Warmly nostalgic (Missing old friends or memories)**
    * *Backend Tags:* `vibe: retro|vintage`, `era: 70s|80s|90s`, `mood: nostalgic`
* **C. Social and collaborative (Ready to party or share)**
    * *Backend Tags:* `vibe: crowd-pleaser|hype`, `mainstream: high`, `mood: extroverted`
* **D. Rebellious and disconnected (In my own lane)**
    * *Backend Tags:* `vibe: alternative|indie`, `underground: high`, `mood: edgy`

### Question 5: What era of music sounds appealing right now?
*Focus: Temporal style and sonic profile.*
* **A. Timeless classics (Golden age, vintage warmth)**
    * *Backend Tags:* `era: pre-1980`, `style: analog|acoustic|classic`
* **B. Retro nostalgia (Synth-heavy, early digital grit)**
    * *Backend Tags:* `era: 1980-2000`, `style: synth-pop|grunge|90s-hiphop`
* **C. Modern landscape (Sleek, current, fresh releases)**
    * *Backend Tags:* `era: 2010-present`, `style: modern-production|clean`
* **D. Futuristic / Ahead of its time (Experimental and boundary-pushing)**
    * *Backend Tags:* `era: avant-garde`, `style: experimental|hyperpop|idm`

### Question 6: What is the primary purpose of playing this music?
*Focus: Behavioral task context.*
* **A. Deep study, coding, or quiet writing**
    * *Backend Tags:* `purpose: focus`, `vocals: none|minimal`, `distraction: low`
* **B. Driving, walking, or physical workouts**
    * *Backend Tags:* `purpose: movement`, `rhythm: steady|upbeat`, `drive: high`
* **C. Winding down for sleep or meditation**
    * *Backend Tags:* `purpose: sleep|meditate`, `tempo: ultra-low`, `relaxing: high`
* **D. Cleaning the house, cooking, or hosting a casual night**
    * *Backend Tags:* `purpose: background_hype`, `tempo: medium-high`, `feel-good: high`

### Question 7: How do you want your heart rate to respond?
*Focus: Physiological feedback.*
* **A. Slow down and breathe easily**
    * *Backend Tags:* `arousal: low`, `soothing: high`, `dynamics: flat`
* **B. Keep a steady, rhythmic pulse**
    * *Backend Tags:* `arousal: medium`, `groove: high`, `dynamics: consistent`
* **C. Skyrocket with high-energy excitement**
    * *Backend Tags:* `arousal: high`, `hype: high`, `dynamics: explosive`
* **D. Go on a wild emotional ride (Big builds and drops)**
    * *Backend Tags:* `arousal: variable`, `cinematic: high`, `dynamics: wide`

---

## 2. 🎬 Movie Recommendation Flow (7 Questions)

### Question 1: What is the ultimate goal of this movie night?
*Focus: Core psychological/emotional driver.*
* **A. Pure, mindless escapism and laughs**
    * *Backend Tags:* `genre: comedy|animation`, `tone: lighthearted`, `intensity: low`
* **B. A dark, edge-of-your-seat adrenaline rush**
    * *Backend Tags:* `genre: thriller|horror|action`, `tone: tense`, `intensity: high`
* **C. A deep, mind-bending intellectual puzzle**
    * *Backend Tags:* `genre: mystery|sci-fi`, `tone: cerebral`, `plot: complex`
* **D. A heavy, cathartic emotional cry**
    * *Backend Tags:* `genre: drama|romance`, `tone: emotional`, `intensity: medium`

### Question 2: How much brainpower do you want to invest?
*Focus: Narrative complexity and structural pacing.*
* **A. Zero thoughts, just pure visual vibes and spectacle**
    * *Backend Tags:* `complexity: low`, `pacing: fast`, `visual_style: blockbusters`
* **B. Keep me engaged, but don't overcomplicate it**
    * *Backend Tags:* `complexity: medium`, `pacing: balanced`, `visual_style: mainstream`
* **C. I want to actively piece together clues and think**
    * *Backend Tags:* `complexity: high`, `pacing: meticulous`, `visual_style: non-linear`
* **D. Give me philosophical existential dread**
    * *Backend Tags:* `complexity: high`, `tone: bleak|philosophical`, `themes: existential`

### Question 3: What kind of world do you want to step into?
*Focus: Setting and production design.*
* **A. Gritty, realistic, and street-level**
    * *Backend Tags:* `setting: contemporary|urban`, `style: realism|neo-noir`
* **B. Magical, epic, or high-concept sci-fi**
    * *Backend Tags:* `setting: futuristic|fantasy`, `style: world-building`
* **C. Glamorous, high-society, or historical past**
    * *Backend Tags:* `setting: period_piece|historical`, `style: stylized`
* **D. Cozy, relatable, and everyday life**
    * *Backend Tags:* `setting: suburban|small_town`, `style: slice_of_life`

### Question 4: How do you feel about tension and suspense?
*Focus: Conflict threshold toleration.*
* **A. Keep it entirely stress-free and safe**
    * *Backend Tags:* `suspense: none`, `threat_level: low`, `vibe: wholesome`
* **B. Mild tension with guaranteed happy resolution**
    * *Backend Tags:* `suspense: low`, `threat_level: medium`, `vibe: satisfying`
* **C. High suspense, constant danger, and stakes**
    * *Backend Tags:* `suspense: high`, `threat_level: high`, `vibe: intense`
* **D. Psychological terror (Mess with my mind)**
    * *Backend Tags:* `suspense: extreme`, `threat_level: psychological`, `vibe: disturbing`

### Question 5: What era of filmmaking fits your mood?
*Focus: Cinematic age and style.*
* **A. Modern Blockbuster (Clean, high-end CGI, modern dialogue)**
    * *Backend Tags:* `era: 2015-present`, `production: modern-high`
* **B. Retro / Modern Classic (The 90s and 2000s sweet spot)**
    * *Backend Tags:* `era: 1990-2015`, `production: practical-heavy`
* **C. Nostalgic Vintage (Old Hollywood, retro film grain, raw audio)**
    * *Backend Tags:* `era: pre-1990`, `production: classic`
* **D. Indie / Art-house (Focus on unique cinematography, not budget)**
    * *Backend Tags:* `era: any`, `production: indie|low-budget`, `focus: artistic`

### Question 6: Who is watching this movie with you?
*Focus: Audience makeup compatibility.*
* **A. Just me, myself, and I (Deeply personal stories)**
    * *Backend Tags:* `audience: solo`, `themes: introspective|character-study`
* **B. Date night (Romance, chemistry, engaging conversations)**
    * *Backend Tags:* `audience: romantic-partner`, `themes: romantic|tension|chemistry`
* **C. Friends or roommates (Crowd-pleaser, easy conversations)**
    * *Backend Tags:* `audience: group`, `themes: interactive|fun|entertaining`
* **D. Family night (Safe for multiple generations)**
    * *Backend Tags:* `audience: family`, `rating: PG|G`, `themes: broad-appeal`

### Question 7: How do you want the pacing of the story to feel?
*Focus: Temporal velocity of the narrative.*
* **A. Fast & Furious (Non-stop action, rapid cuts, high tempo)**
    * *Backend Tags:* `pacing: hyper_fast`, `storytelling: action_led`
* **B. Smooth & Steady (Classic 3-act structure, easy flow)**
    * *Backend Tags:* `pacing: balanced`, `storytelling: conventional`
* **C. Slow Burn (Atmospheric, quiet moments, rewarding climax)**
    * *Backend Tags:* `pacing: slow_burn`, `storytelling: character_led`
* **D. Artistic & Dreamlike (Abstract, poetic, visual-centric)**
    * *Backend Tags:* `pacing: fluid|abstract`, `storytelling: non-linear`

---

## 3. 📺 Series Recommendation Flow (7 Questions)

### Question 1: What kind of time commitment are you looking for?
*Focus: Formatting runtime limits.*
* **A. Fast, self-contained episodic laughs (Sitcom style)**
    * *Backend Tags:* `format: sitcom`, `runtime: 20-30m`, `serialized: low`
* **B. A short, high-intensity limited series (One-and-done)**
    * *Backend Tags:* `format: limited_series`, `runtime: 45-60m`, `serialized: high`
* **C. A massive, multi-season universe to get lost in**
    * *Backend Tags:* `format: multi_season`, `seasons: >3`, `serialized: high`
* **D. Cozy background viewing (Low-stakes, episodic comfort)**
    * *Backend Tags:* `format: episodic|reality`, `tone: low_stakes`, `comfort_watch: true`

### Question 2: What is the primary hook you need right now?
*Focus: Hook-types and plot mechanics.*
* **A. Non-stop cliffhangers and shocking twists**
    * *Backend Tags:* `hook: cliffhanger`, `pacing: hyper_fast`, `subgenre: mystery|conspiracy`
* **B. Quick-witted, hilarious character banter**
    * *Backend Tags:* `hook: dialogue`, `pacing: fast`, `subgenre: sitcom|dramedy`
* **C. Complex political intrigue and power struggles**
    * *Backend Tags:* `hook: world_politics`, `pacing: steady`, `subgenre: historical|fantasy_politics`
* **D. Deep, slow-burn psychological character studies**
    * *Backend Tags:* `hook: character_arc`, `pacing: slow_burn`, `subgenre: psychological_drama`

### Question 3: How do you want to feel when the final credits roll?
*Focus: Climax configuration and resolution.*
* **A. Stunned, staring at the wall questioning reality**
    * *Backend Tags:* `ending: twist|ambiguous`, `resolution: open_ended`
* **B. Warm, happy, and fully comforted**
    * *Backend Tags:* `ending: uplifting|resolved`, `resolution: happy_ending`
* **C. Empowered, motivated, and inspired**
    * *Backend Tags:* `ending: triumphant`, `resolution: inspiring`
* **D. Hauntingly reflective and bittersweet**
    * *Backend Tags:* `ending: bittersweet|tragic`, `resolution: emotional`

### Question 4: How dark are you willing to go with themes?
*Focus: Psychological and moral threshold.*
* **A. Light, bright, and purely optimistic**
    * *Backend Tags:* `tone: light`, `themes: optimistic|wholesome`, `intensity: low`
* **B. Realist (Life has ups and downs, but mostly hopeful)**
    * *Backend Tags:* `tone: realistic`, `themes: balanced`, `intensity: medium`
* **C. Gritty, cynical, and morally grey**
    * *Backend Tags:* `tone: dark`, `themes: moral-ambiguity`, `intensity: high`
* **D. Pitch black (Grim, psychological horror, no easy ways out)**
    * *Backend Tags:* `tone: grimdark`, `themes: survival|terror`, `intensity: extreme`

### Question 5: What is your ideal character dynamic?
*Focus: Relationship frameworks.*
* **A. Ensemble cast of quirky, lovable friends**
    * *Backend Tags:* `characters: ensemble`, `vibe: found_family|friendship`
* **B. One iconic, powerful lead carrying the show**
    * *Backend Tags:* `characters: solo-lead`, `vibe: hero-journey|antihero`
* **C. A fierce rivalry / Cat-and-mouse chase**
    * *Backend Tags:* `characters: duel`, `vibe: psychological-rivalry|crime-chase`
* **D. Interweaving, multi-perspective timelines**
    * *Backend Tags:* `characters: sprawling`, `vibe: family-saga|political-dynasty`

### Question 6: What should the visual design of the show be?
*Focus: Aesthetic and artistic presentation.*
* **A. Clean, modern, bright, and high-budget**
    * *Backend Tags:* `visuals: clean|hd`, `color_palette: bright`, `budget: high`
* **B. Moody, shadow-filled, dramatic, and artistic**
    * *Backend Tags:* `visuals: cinematic|shadowy`, `color_palette: dark|muted`, `budget: medium-high`
* **C. Vintage, nostalgic, retro-graded film look**
    * *Backend Tags:* `visuals: retro|stylized`, `color_palette: warm|saturated`
* **D. Surreal, abstract, animated, or highly stylized**
    * *Backend Tags:* `visuals: animated|surreal`, `color_palette: vibrant`

### Question 7: What level of "world-building" details do you want?
*Focus: Depth of setting details.*
* **A. Absolutely none (Set in our normal, everyday world)**
    * *Backend Tags:* `setting: present_day`, `world_building: zero`
* **B. Light Twist (Our world, but with one secret difference)**
    * *Backend Tags:* `setting: magical_realism|subtle_scifi`, `world_building: light`
* **C. Elaborate History (Period pieces, real events, massive sets)**
    * *Backend Tags:* `setting: historical`, `world_building: medium`
* **D. Total Fantasy/Sci-Fi (Brand-new rules, maps, tech, languages)**
    * *Backend Tags:* `setting: high_fantasy|space_opera`, `world_building: extreme`