# Media Recommendation Questionnaire & Backend Tag Mapping Engine

This document contains highly optimized, 4-option questionnaire tracks for **Music**, **Movies**, and **Series**. Each question and answer option is mapped directly to structural metadata tags to enable frontend and backend developers to easily implement a dynamic filtering system.

---

## 1. 🎵 Music Recommendation Flow

### Question 1: What is your current energy level?
*Focus: Tempo, Energy, and Rhythm tracking.*

* **A. Completely drained (Need a soft landing)**
    * *Backend Tags:* `tempo: low`, `energy: low`, `vibe: acoustic|ambient`, `acousticness: high`
* **B. Focused and steady (In the zone)**
    * *Backend Tags:* `tempo: medium`, `energy: medium`, `vibe: lofi|minimal|classical`, `instrumentalness: high`
* **C. Hyped and restless (Ready to move)**
    * *Backend Tags:* `tempo: high`, `energy: high`, `vibe: dance|electronic|hip-hop`, `danceability: high`
* **D. Frustrated/Anxious (Need a sonic release)**
    * *Backend Tags:* `tempo: high|medium`, `energy: high`, `vibe: rock|metal|punk|grunge`, `loudness: high`

### Question 2: Pick an environment that matches your vibe right now:
*Focus: Texture, Tone, and Sub-genre grouping.*

* **A. A rainy midnight drive through neon streets**
    * *Backend Tags:* `aesthetic: synthwave|dreampop|jazz`, `mood: melancholic|reflective`
* **B. A sunny, crowded afternoon coffee shop**
    * *Backend Tags:* `aesthetic: indie|folk|pop`, `mood: cheerful|warm`
* **C. A dark, underground club basement**
    * *Backend Tags:* `aesthetic: techno|house|trap`, `mood: hypnotic|intense`
* **D. A peaceful cabin deep in the woods**
    * *Backend Tags:* `aesthetic: folk|neo-classical|ambient`, `mood: serene|isolated`

### Question 3: What should the music focus on?
*Focus: Primary audio characteristics.*

* **A. Deep, poetic storytelling and lyrics**
    * *Backend Tags:* `focus: vocal_driven`, `genres: singer-songwriter|rap|folk`
* **B. Heavy basslines and hard-hitting beats**
    * *Backend Tags:* `focus: beat_driven`, `genres: edm|hip-hop|rnb`
* **C. Smooth, atmospheric instrumental waves**
    * *Backend Tags:* `focus: instrumental`, `genres: ambient|post-rock|lofi`
* **D. Catchy, feel-good, upbeat melodies**
    * *Backend Tags:* `focus: melody_driven`, `genres: pop|funk|disco`

---

## 2. 🎬 Movie Recommendation Flow

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

* **A. Zero thoughts, just pure visual vibes**
    * *Backend Tags:* `complexity: low`, `pacing: fast`, `visual_style: blockbusters|spectacle`
* **B. Keep me engaged, but don't stress me out**
    * *Backend Tags:* `complexity: medium`, `pacing: balanced`, `visual_style: mainstream`
* **C. I want to actively piece together clues**
    * *Backend Tags:* `complexity: high`, `pacing: meticulous`, `visual_style: non-linear|puzzle`
* **D. Give me philosophical existential dread**
    * *Backend Tags:* `complexity: high`, `tone: bleak|philosophical`, `themes: existential`

### Question 3: What kind of world do you want to step into?
*Focus: Mise-en-scène, setting, and production design.*

* **A. Gritty, realistic, and street-level**
    * *Backend Tags:* `setting: contemporary|urban`, `style: realism|neo-noir`
* **B. Magical, epic, or high-concept sci-fi**
    * *Backend Tags:* `setting: futuristic|fantasy`, `style: world-building`
* **C. Glamorous, high-society, or nostalgic past**
    * *Backend Tags:* `setting: period_piece|historical`, `style: stylized`
* **D. Cozy, relatable, and everyday life**
    * *Backend Tags:* `setting: suburban|small_town`, `style: slice_of_life`

---

## 3. 📺 Series Recommendation Flow

### Question 1: What kind of commitment are you looking for?
*Focus: Formatting runtime limits.*

* **A. Fast, self-contained episodic stories**
    * *Backend Tags:* `format: procedural|sitcom`, `runtime: 20-30m`, `serialized: low`
* **B. A short, high-intensity miniseries**
    * *Backend Tags:* `format: limited_series`, `runtime: 45-60m`, `serialized: high`
* **C. A massive, multi-season universe to get lost in**
    * *Backend Tags:* `format: multi_season`, `seasons: >3`, `serialized: high`
* **D. A comforting, low-stakes show I can half-watch**
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
*Focus: Climax configuration and resolution dynamics.*

* **A. Stunned, staring at the wall questioning everything**
    * *Backend Tags:* `ending: twist|ambiguous`, `resolution: open_ended`
* **B. Warm, happy, and comforted**
    * *Backend Tags:* `ending: uplifting|resolved`, `resolution: happy_ending`
* **C. Empowered, motivated, and inspired**
    * *Backend Tags:* `ending: triumphant`, `resolution: inspiring`
* **D. Hauntingly reflective and melancholic**
    * *Backend Tags:* `ending: bittersweet|tragic`, `resolution: emotional`

---

## 4. 🛠️ Development Integration Architecture (For Implementation Agents)

```
       [ USER SELECTIONS ] 
  (Ans 1: A)   (Ans 2: C)   (Ans 3: B)
       |            |            |
       v            v            v
  [Tags Set 1] [Tags Set 2] [Tags Set 3]
       |            |            |
       +------------+------------+
                    |
                    v (Array Intersection)
         Final Query Parameter Map
                    |
                    v
    [ DATABASE API REQUEST / MATCH ENGINE ]
```

### Filtering Algorithm Strategy
1.  **Tag Aggregation:** When a user selects answers across the 3 questions, compile the associated tags into a query array.
2.  **Weighted Intersections:** Instruct your backend queries to calculate a matching coefficient. For example, if an item matches tags from all 3 categories (`Intersects == 3`), it surfaces to the top of your recommendation list.
3.  **Fallback Logic:** If zero items strictly match the intersection of all chosen tags, drop the lowest priority modifier tag (e.g., drop the *setting* or *environment* tag, maintaining the *energy* and *focus* values) to ensure the engine always outputs results.
