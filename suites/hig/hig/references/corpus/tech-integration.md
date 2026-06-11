<!-- hig-snapshot: 2026-06-11 · baseline: iOS 26.x / macOS 26.x · src: maps, voiceover -->

# Technologies — platform integration

Promoted from live-fetch-only (2026-06-11) as high-traffic topics; the remaining niche slugs stay in index.md's live-fetch-only list.

## maps
<!-- src: maps · changed: 2024-12-18 (place cards) · platforms: iOS, iPadOS, macOS · speed: full -->
MapKit map views: annotations, overlays, place cards, indoor maps.
- **Make the map interactive** — people expect zoom/pan/rotate; non-interactive elements obscuring the map break expectations.
- **Help people find places:** offer search combined with category filters (a mall map filters by clothing, housewares, electronics…).
- **Emphasis styles** (`MKStandardMapConfiguration.EmphasisStyle`): *default* = fully saturated, visually aligned with the Maps app (most apps); *muted* = desaturated, for information-rich custom content that must stand out against the map.
- **Apple logo + legal link must stay visible** (App-Review-sensitive brand rule): ~**7pt padding on the sides, 10pt above/below**; they must appear fixed to the map, never moving with your UI; if a card pulls up from the bottom, place them **10pt above its lowest resting position**. Not shown on maps smaller than **200×100px**.
- **Annotations** (`MKAnnotationView`): default marker is red tint + white pin; re-tint to your scheme; icon may be a string — keep it **2–3 characters**. Cluster overlapping points of interest; clusters expand on zoom. Selected elements get distinct styling (outline + colour change). Custom controls need contrast against the map — thin stroke, light shadow, or blend mode.
- **Overlays** (`MKOverlayLevel`): *above roads* (default — terrain stays legible beneath) vs *above labels* (hides everything; for fully abstracted or masked areas).
- **Place cards** (since 2024-12-18; `mapItemDetailSelectionAccessory(_:)`, `MKSelectionAccessory`): styles = *automatic* · *callout* (full = rich detail; compact = space-saving) · *caption* ("Open in Apple Maps" link only) · *sheet*. **Platform delta:** full callout renders as a popover on iPadOS/macOS but as a sheet on iOS. Small map + many annotations → compact callout. Outside a map view, a place card **must embed a map** (`mapItemDetailSheet(item:displaysMap:)`). Don't duplicate info the surrounding UI already shows; keep the selected location visible (set an accessory offset).
- **Indoor maps** (IMDF): progressive detail by zoom (rooms/buildings at every level, stores/restrooms zoomed-in); floor picker uses floor **numbers**, not names; dim non-interactive surroundings; limit scrolling beyond the venue; style overlays/icons to match your app — **don't replicate the Maps app's look**.
**Checks.** Logo/legal link permanently covered or moving with UI → flag (tier 2; brand-sensitive) · non-interactive map without cause → flag · >3-char annotation strings → flag · full-callout place card duplicating adjacent UI → suggest compact/caption.

## voiceover
<!-- src: voiceover · changed: 2025-03-07 — NEW page (post-dates most priors) · platforms: iOS, iPadOS, macOS · speed: full -->
Screen-reader support; deepens `accessibility` (foundations-people). New page 2025-03-07 — models with older priors won't know it exists as a distinct spec.
- **Labels:** alternative labels for **all key interface elements** — system controls ship generic labels; override with ones that state your app's function; label every custom element; keep labels in sync as UI changes.
- **Images:** describe what the image itself conveys, not its surroundings (VoiceOver already reads nearby captions); mark decorative images hidden (`accessibilityHidden(_:)`; the `isAccessibilityElement` property) — describing them wastes the listener's time.
- **Charts/infographics:** concise description of what each conveys; interactive infographics must expose their interactions through the accessibility APIs (see `charts`).
- **Titles & headings:** the title is the **first thing VoiceOver reads** on arrival — unique per screen, purpose-stating; accurate section headings build the mental model.
- **Grouping & order:** reading order follows locale reading order (US English: top-to-bottom, left-to-right) — visual-only relationships (proximity, alignment) are invisible to VoiceOver; group elements so captions read with their images (`shouldGroupAccessibilityChildren`).
- **Change announcements:** report visible content/layout changes (`AccessibilityNotification`) — silent changes invalidate the listener's mental map.
- **Rotor:** identify headings, links, and content types to the rotor (`AccessibilityRotorEntry` / `UIAccessibilityCustomRotor` / `NSAccessibilityCustomRotor`) so people can jump by type.
**Checks.** Custom element without a label → flag (tier 2) · decorative images not excluded → flag (tier 3) · screen titles non-unique or missing → flag · layout change without announcement → flag · image label describing the caption instead of the image → flag.
