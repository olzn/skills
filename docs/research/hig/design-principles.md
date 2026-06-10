# HIG research notes — design-principles (+ getting-started completion)

> Bucket: the HIG's top-level framing page (Getting started section), reintroduced at WWDC 2026, plus the one remaining in-scope Getting started page not covered elsewhere (Designing for games, brief).
> Source: Apple JSON content API (`developer.apple.com/tutorials/data/design/human-interface-guidelines/<slug>.json`), fetched 2026-06-10.
> Currency: Design principles page is **brand new as of 2026-06-08** ("Reintroduced design principles" — its only change-log entry). Designing for games last changed 2025-06-09.
> Getting started coverage map: `designing-for-ios`, `designing-for-macos` → platform notes elsewhere; `designing-for-ipados` → platforms-tech.md (adaptivity brief); `designing-for-watchos`/`-tvos`/`-visionos` → out of scope; `designing-for-games` → below; `design-principles` → this file. Section complete.

---

## Design principles

**Canonical URL:** https://developer.apple.com/design/human-interface-guidelines/design-principles
**Platforms:** all (platform-agnostic; applies equally to iOS and macOS).
**Change log:** June 8, 2026 — "Reintroduced design principles." (only entry; page metadata alert-date 2026-06-08).
**Companion video:** WWDC 2026 session 250, "Principles of great design" — https://developer.apple.com/videos/play/wwdc2026/250

### Purpose
The HIG's new top-level conceptual framing. Apple's framing text: "The most successful and enduring designs are based on a deep understanding of how people think, feel, and interact with the world. The principles here reflect this reality, and form the foundation for guidance throughout the Human Interface Guidelines. **There's no one right way to apply these principles. Instead, they're tools to help you weigh competing priorities and make key decisions** on the path to a great design."

Eight named principles, each with a one-line tagline (shown on the page's intro cards) plus 2–4 bolded rules with supporting text. Apple explicitly positions them as trade-off instruments, not a checklist — useful for a skill suite as severity/rationale vocabulary, not as pass/fail gates by themselves.

### Stale-knowledge corrections
- **Pre-2023 iOS HIG had six different principles** (Aesthetic Integrity, Consistency, Direct Manipulation, Feedback, Metaphors, User Control). The 2023 cross-platform HIG redesign **removed** the dedicated principles page entirely. Models trained on pre-2025 material will cite the old six; they are obsolete. The current canonical set (2026-06-08) is **eight**: Purpose, Agency, Responsibility, Familiarity, Flexibility, Simplicity, Craft, Delight.
- Rough lineage: User Control + Feedback → Agency + Familiarity ("Provide clear feedback" now lives under Familiarity); Metaphors + Consistency → Familiarity; Aesthetic Integrity → Craft + Delight; Direct Manipulation has no direct heir (subsumed by Agency's "get them directly to the task").
- **Genuinely new emphases with no pre-2023 counterpart:** Responsibility (privacy, transparency, trust as a *design* principle) and Flexibility (accessibility, inclusion, input diversity, and multi-platform intention elevated to first-order principles).
- "Maintain your craft" explicitly makes **keeping current with the latest platform capabilities and design patterns** a principle — in the Liquid Glass era this is Apple-sanctioned grounds to flag pre-2025 visual conventions (opaque bars, old icon styles) as a craft violation, not merely a style preference.

### The eight principles — full guidance text

#### 1. Purpose — "Make something meaningful."
Card text: Design starts with intention. Identify what matters most to the people you're designing for. Focus on making those things great, and you'll create an experience that people truly value.

- **Create value.** The best designs reflect a constant orientation toward what makes a product genuinely useful. At every stage of development, ask what your product is for and whether the design serves that purpose.
- **Keep focused.** Prioritize your app's most important features by aligning with how people want to use it, and focus on making those features truly great. A product with a clear use is more effective at helping people meet their goals.
- **Find new ways to solve the problem.** Investigate existing solutions, and avoid re-creating them. Define what sets your product apart, and ask how your design can reflect that.

#### 2. Agency — "Let people do things their own way."
Card text: An interface exists to help people accomplish their goals. Give them the freedom to act, keep them informed about what's happening, and make it easy to recover from mistakes.

- **Stay out of the way.** People use your product to get things done. Often the best way to help them do this is to get them directly to the task or content at hand. The best designs are unobtrusive and present when people need them.
- **Give people the freedom to explore.** Let them move through your interface and access features without being locked into specific flows or modes. When a guided flow is necessary, make it easy to skip or escape so people can get to the main experience quickly.
- **Help people recover from mistakes.** When people know they can reverse an action or return to a previous state, they feel free to explore, and that freedom makes your interface more inviting. Build forgiveness into your design, and make it easy. Recovering from the unexpected shouldn't cost people their time or work.

#### 3. Responsibility — "Act in people's best interest."
Card text: Your work has an impact on people's lives. Earn their trust by prioritizing safety and privacy, and being transparent about what your product does and why.

- **Be fully transparent about what your product does and why.** You have an opportunity to build a relationship with someone from their very first interaction. Make sure your app's intentions are clear from the start. Provide a clear rationale when asking for permission, and when gathering data, be clear about what you collect and how you use it.
- **Keep people's information safe.** People trust you to maintain the integrity of their data. Only collect what your product needs to function, and handle it with care. Anticipate ways it could be misused or cause harm, and put protections in place to prevent abuse and unintended consequences.

#### 4. Familiarity — "Build on what people know."
Card text: Drawing on concepts people already understand helps them feel immediately at home. Ground your experience in established physical and digital patterns and apply them consistently throughout your design.

- **Use concepts that people know.** People bring knowledge of the real world and other software to every new experience. Draw on both to make your interface feel familiar and intuitive.
- **Keep visuals and interactions consistent.** Once you establish a behavior or appearance for an element, apply it throughout your design. Consistency helps people learn more quickly, and gives them confidence that new interactions will work the way they expect.
- **Provide clear feedback.** Give people clear signals about what's happening as they use your app. Show when controls are available, indicate when content changes, and **use system patterns to display alerts and offer choices**. Consistent feedback helps keep people informed and in control.

#### 5. Flexibility — "Adapt to diverse contexts and needs."
Card text: People use your software in ways as unique as they are. The more your design acknowledges this, the more people feel welcome to use it. Be mindful of experiences other than yours, and try to support as many devices, types of interaction, and perspectives as possible.

- **Design for everyone.** People are empowered by products designed with them in mind. Think about the diversity of people who may encounter your design, and take the range of their experiences, perspectives, and needs into account. **Treat accessibility as a priority from the start.** Design inclusively to reach the broadest possible audience and create a better experience for all.
- **Preserve a person's context.** Help people feel at home as your design adapts across platforms and configurations. Keep content and controls in consistent, predictable positions, and use natural animations to ease transitions.
- **Consider a variety of input methods.** People interact with their devices in different ways. Designing for as many inputs as possible — including voice, touch, keyboard, and more — means more people can use your product the way that works best for them.
- **Approach every platform with intention.** Your software should feel polished and at home wherever it runs. Give each platform you support the same level of care.

#### 6. Simplicity — "Be clear and direct."
Card text: A well-designed experience removes the unnecessary, with every element earning its place. When your interface is logically organized and straightforward to navigate, it's easier to get things done.

- **Include just what's necessary.** **Simplicity isn't minimalism.** Aim for a focused, useful experience that keeps the important things close by and lets the others fall away.
- **Be concise.** When you find the simplest way to say something, it's often the most universal, and the most helpful. Choose exactly the words you need to convey a concept or label a control.
- **Establish hierarchy.** When form and function are readily apparent, people know how to reach a desired outcome. Prioritize recognizable controls and a consistent structure that helps people understand where they are and what comes next.

#### 7. Craft — "Care about every detail."
Card text: Your design is a reflection of how much you care. It shows your dedication to delivering the best possible experience for people. Take the time to do the work well.

- **Quality sets the tone.** Every element of your design shows people how much you care. Be deliberate with each decision, and strive for stunning visuals, smooth animations, precise wording, and thoughtful audio.
- **Experiment and iterate.** Prototype early, try new approaches, and be willing to discard what doesn't work. Set a high bar for every feature, refine it, and try again. Test your product in real-world settings to make sure it's durable, reliable, and high-performing.
- **Maintain your craft.** Shipping isn't the finish line. **Keep your interface current with the latest platform capabilities and design patterns**, and keep the quality bar high. Design is an ongoing commitment.

#### 8. Delight — "Make it human."
Card text: People remember how a product makes them feel. Think about the emotions that are right for your experience, and aim to deliver them in a way that's satisfying, enriching, and a joy to use.

- **Identify the emotion you want to inspire.** Not all software feels the same to use. A fitness app might energize; a meditation app might calm; a game might thrill. Know the feeling you want to evoke, and let it shape your design.
- **Create defining moments.** Every interaction is a chance to show what your software stands for. From a simple button press to an error message, consider whether each moment is an opportunity to add a touch of character that reflects the spirit of your design.
- **Don't mistake delight for decoration.** Keep in mind that people are trying to accomplish a task, so don't let pursuit of delight for its own sake get in the way of your product's core purpose. Think about your overall aesthetic: some designs benefit from a carefully considered practical touch, while others might prefer some whimsy. Experiment to find the right balance.
- **Consider the whole.** Delight emerges as the sum of the consideration that you put into your product — the culmination of everything a person experiences: the freedom to act, the safety to explore, the comfort of familiar metaphors, and the flexibility to transition from one context to another. Design with intent, focus, and care, and the result is naturally delightful.

### Principle → reviewer-check mapping
The page itself is non-numeric; concrete thresholds live in the topic pages (cross-refs below point at the other notes files). Use principles as the *finding category*, the topic page as the *citable spec*.

| Principle | Concrete checkable violations |
|---|---|
| **Purpose** | Launch doesn't land on core content (marketing carousel, dashboard of secondary features first). Toolbar/settings stuffed with rarely used controls instead of the primary task. Feature added with no relation to the product's stated job. |
| **Agency** | Onboarding/guided flow with no visible Skip or escape route. Main experience gated behind account creation or a forced tour. Destructive action with neither undo nor confirmation; macOS app ignoring Edit > Undo / ⌘Z; data-loss path with no recovery. Modal lock-in: user can't navigate away mid-flow without losing work. Interruptive overlays (rating prompts, upsells) before the user has done anything. |
| **Responsibility** | Permission request at launch instead of in context of the triggering feature; purpose string vague or missing rationale ("This app needs your location"). Data collected beyond what the feature needs. Disclosure mismatch between UI claims and privacy nutrition label. (Spec source: privacy notes in foundations-people.md.) |
| **Familiarity** | Custom lookalike replacing a system alert/action-sheet/confirmation pattern ("use system patterns to display alerts and offer choices" is verbatim normative). Same icon or gesture doing different things in different screens; same action styled differently across screens. Controls with no disabled/enabled signalling; content changes with no loading or change indication. Real-world/platform metaphors broken (e.g. swipe-back hijacked). |
| **Flexibility** | No Dynamic Type support; missing VoiceOver labels; contrast failures — accessibility deferred to "later" is by definition a principle violation ("from the start"). Layout shifts controls to unpredictable positions across size classes/window sizes; abrupt unanimated context transitions. Single-input assumption: iOS app unusable with keyboard where expected (iPad), macOS app without keyboard shortcuts, missing Voice Control labels. Straight port: iOS idioms verbatim on macOS or vice versa ("approach every platform with intention" — cite designing-for-macos/-ios notes for specifics). |
| **Simplicity** | Verbose or jargon control labels where one exact word works. No discernible hierarchy: unrecognizable custom controls, inconsistent structure, user can't tell where they are or what's next. Inverse failure — *minimalism mistaken for simplicity*: essential controls hidden behind ambiguous icons or buried menus to look clean (Apple explicitly says simplicity ≠ minimalism). |
| **Craft** | Janky/dropped-frame animation, placeholder or imprecise wording, low-res assets. Stale-pattern findings: pre-Liquid-Glass opaque bars, legacy icon not rebuilt for the layered system, deprecated navigation patterns — "maintain your craft / keep your interface current" is the citable basis. Untested edge contexts (long text, slow network) breaking layout. |
| **Delight** | Decoration blocking tasks: gratuitous animation delaying completion, character copy obscuring an error's actual remedy. Tonal mismatch with the app's intended emotion (whimsy in a banking error). No defining moments at all is a soft finding, never a violation — flag only when explicitly auditing brand character. |

**Skill-architecture note:** the 8 names are stable, Apple-canonical, mutually exclusive enough to tag every finding from every other HIG page. Purpose/Craft/Delight are judgment-heavy (best for advisory findings); Agency/Responsibility/Familiarity/Flexibility/Simplicity map cleanly to mechanical checks backed by numeric specs elsewhere.

---

## Designing for games (brief)

**Canonical URL:** https://developer.apple.com/design/human-interface-guidelines/designing-for-games
**Platforms:** all. **Change log:** 2025-06-09 "Updated guidance for touch-based controls and Game Center"; 2024-06-10 new page.
Niche for the skill suite (games only), but it's the one Getting started page with hard numbers, and they corroborate specs elsewhere.

**Jump into gameplay**
- Playable after initial install with download time **≤ 30 minutes**; stream additional content in background.
- Great defaults from device info (resolution, paired controllers, accessibility settings); playable tutorial over written prerequisite; defer permission/rating requests until the scenario that needs them ("integrate it into the scenario that requires the data").

**Display specs (iOS/macOS rows; same tables as Accessibility/Typography pages):**

| Platform | Default text | Min text | Default button | Min button |
|---|---|---|---|---|
| iOS, iPadOS | 17 pt | 11 pt | 44×44 pt | 28×28 pt |
| macOS | 13 pt | 10 pt | 28×28 pt | 20×20 pt |

- Resolution-independent assets preferred; respect safe areas (rounded corners, camera housing); in-game menus must survive aspect ratios **16:10, 19.5:9, 4:3** and both orientations — dynamic/relative layouts, avoid fixed.
- Design for full-screen: macOS/iOS/iPadOS full-screen mode hides other apps and system UI.

**Interaction (iOS vs macOS difference):**

| Platform | Default input | Additional |
|---|---|---|
| iOS | Touch | Game controller |
| macOS | Keyboard, mouse, trackpad | Game controller |

- Support each platform's default input; controller optional, never required — always offer alternatives. Touch controls on iPhone/iPad should "embrace the touchscreen" (direct element interaction + virtual overlay controls), with care porting pointer-based control sizing/menus to touch.

**Inclusion:** perceivability across sight/hearing/touch (no color-only signals; subtitles on cutscenes); player-customizable type size, control mapping, motion intensity, sound balance; avatar/self-identity breadth; audit stories/characters for stereotypes.

**Apple tech:** Game Center (social layer, leaderboards, challenges — see platforms-tech.md), **GameSave** framework (2025, cross-device saves via iCloud), Core Haptics (iOS yes, macOS not listed), Spatial Audio.

**Reviewer checks:** game text below 11 pt iOS / 10 pt macOS; touch targets below minimums; fixed-layout menus clipped at non-native aspect ratios; controller-required gameplay with no touch/keyboard alternative; permission battery at first launch; color-only game state signals.
