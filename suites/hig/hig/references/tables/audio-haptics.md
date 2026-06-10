<!-- hig-snapshot: 2026-06-10 · baseline: iOS 26.x / macOS 26.x · src: playing-audio, playing-haptics -->

# Audio session categories and haptic patterns

Both pages are stable (playing-audio 2023-06-21; playing-haptics 2024-05-07, Apple Pencil Pro) — bake-safe through Liquid Glass. <!-- src: playing-audio, playing-haptics -->

## Audio session categories (verbatim HIG decision table)
| Category | Meaning | Silent switch | Mixes with other audio | Background |
|---|---|---|---|---|
| Solo ambient | sound nonessential; silences other audio (game with soundtrack) | Responds | No | No |
| Ambient | sound nonessential; doesn't silence others (game allowing other-app music) | Responds | Yes | No |
| Playback | sound essential (audiobook, language app) | Ignores | Maybe | Can play |
| Record | sound recorded (note-taking recorder) | Ignores | No | Can record |
| Play and record | records and plays, possibly simultaneously (calls, audio messaging) | Ignores | Maybe | Can record and play |
<!-- src: playing-audio -->

## Audio rules
- Silent mode plays only audio people explicitly initiate (media playback, alarms, audio/video messaging); silence everything nonessential — keyboard clicks, sound effects, game soundtracks, audible feedback. <!-- src: playing-audio -->
- Never adjust the overall system volume; mix via relative, independent in-app levels. Use the system volume view (`MPVolumeView`: slider + reroute control) — no custom volume UI. The iPhone ringer volume is the sole separately adjustable exception. <!-- src: playing-audio -->
- Disconnecting headphones pauses playback immediately; connecting reroutes without interruption. Permit rerouting (stereo, car, Apple TV) unless there's a compelling reason not to. <!-- src: playing-audio -->
- Respond to audio controls (Control Center, headphone buttons) only when it makes sense — actively playing, clear audio context, or Bluetooth/AirPlay-connected; never hijack another app's audio; never repurpose controls; custom player controls only for commands the system doesn't support. <!-- src: playing-audio -->
- Flag your session on deactivation (`notifyOthersOnDeactivation`). Resuming after interruption: incoming call = resumable; someone starting a new playlist = nonresumable; a game soundtrack can resume unconditionally (its audio wasn't an explicit user choice). <!-- src: playing-audio -->
- iOS/iPadOS: use the system sound services for short sounds and vibrations. macOS: no silent switch; notification sounds mix with other audio by default. <!-- src: playing-audio -->

## iOS haptic patterns (`UIFeedbackGenerator`, supported iPhones)
Standard components (switches, sliders, pickers) play system haptics automatically. <!-- src: playing-haptics -->

| Category | Meaning | Cited examples |
|---|---|---|
| Notification | outcome of a task | deposit completed, vehicle unlocked |
| Impact | physical metaphor | view snapping into place, collision thud |
| Selection | value changes while manipulating a UI element | — |
<!-- src: playing-haptics -->

## macOS haptic patterns (Force Touch trackpad — drag operations or force clicks ONLY)
| Pattern | Use |
|---|---|
| Alignment | dragged item aligns: shape snapping, scale-to-fit, reaching min/max or start/end of a scrubber |
| Level change | discrete pressure levels (pressing deeper on fast-forward changes speed) |
| Generic | anything else |

macOS designs invoking haptics outside drag/force-click contexts are unsupported — flag. <!-- src: playing-haptics -->

## Haptic rules
- Use system patterns per their documented meanings; never repurpose (a failure pattern must not also signal success); no documented fit → generic or custom. <!-- src: playing-haptics -->
- Custom building blocks: **transient** events (brief, compact — the Flashlight button tap) and **continuous** events (sustained — the lasers message effect), parameterised by **sharpness** (soft/rounded/organic ↔ crisp/precise/mechanical) and **intensity**; may vary dynamically and include audio (Core Haptics). <!-- src: playing-haptics -->
- Complement, don't replace, other feedback — match haptic intensity/sharpness to the accompanying animation. <!-- src: playing-haptics -->
- Occasional, not frequent; prefer short haptics tied to discrete events; provide a setting to turn haptics off and keep the app fully functional without them. <!-- src: playing-haptics -->
- Haptic vibration can disrupt camera, gyroscope or microphone — check those interactions; never specify haptics during capture or recording. <!-- src: playing-haptics -->
- External devices: game controllers (iPadOS/macOS/tvOS/visionOS) and Apple Pencil Pro support haptics; avoid continuous haptics on Pencil — unpleasant to hold. <!-- src: playing-haptics -->
