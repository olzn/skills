# Animation Vocabulary

Use this reference when the user asks what an animation is called, needs prompt vocabulary, or uses vague language such as "make it pop", "morph this", "animate the layout", or "make the transition feel connected".

This file names patterns. It does not decide whether a motion pattern is appropriate. Use `surface-interaction` for intent, spatial logic, gesture behaviour, and frequency.

## Entrances And Exits

**Fade in / fade out:** An element appears or disappears by changing opacity.

**Slide in:** An element enters by sliding in from off-screen: left, right, top, or bottom.

**Scale in:** An element grows from slightly smaller to full size as it appears, usually paired with opacity.

**Pop in:** An element appears with slight overshoot or bounce.

**Reveal:** Content is uncovered gradually, often with `clip-path`, a mask, or a wrapper.

**Enter / exit:** The animation an element plays when it is added to or removed from the screen.

## Sequencing And Timing

**Keyframes:** Defined points in an animation, such as `0%`, `50%`, and `100%`, that the browser interpolates between.

**Interpolation / tween:** The generated in-between frames between a start and end value.

**Stagger:** Several elements animate one after another with a small delay between each item.

**Orchestration:** Multiple animations deliberately timed so they read as one coordinated event.

**Delay:** Time before an animation starts.

**Duration:** How long an animation takes.

**Fill mode:** Whether an element keeps the first or last frame's styles before the animation starts or after it ends.

**Stepped animation:** An animation divided into discrete steps, such as a countdown timer.

## Movement And Transforms

**Translate:** Move an element along the X, Y, or Z axis.

**Scale:** Make an element bigger or smaller.

**Rotate:** Spin an element around a point.

**Skew:** Slant an element along the X or Y axis.

**3D tilt / flip:** Rotate in 3D space with `rotateX` or `rotateY`.

**Perspective:** The strength of a 3D effect. Lower values exaggerate depth.

**Transform origin:** The anchor point a scale or rotation grows or spins from.

**Origin-aware animation:** An element animates out from its trigger, such as a popover growing from the button that opened it rather than from its own centre.

## Transitions Between States

**Crossfade:** One element fades out while another fades in, usually in the same position.

**Continuity transition:** A transition that keeps the user oriented by visually connecting the before and after states.

**Morph:** One shape smoothly turns into another.

**Shared element transition:** An element travels and transforms from one position into another, such as a thumbnail expanding into a detail card.

**Layout animation:** An element's size or position animates to its new layout position instead of snapping.

**Accordion / collapse:** A section smoothly expands or collapses its height to show or hide content.

**Direction-aware transition:** Content moves one way going forward and the opposite way going back.

## Scroll And Navigation

**Scroll reveal:** Elements fade or slide into place as they enter the viewport.

**Scroll-driven animation:** Animation progress is tied directly to scroll position.

**Parallax:** Background and foreground layers move at different speeds while scrolling to create depth.

**Page transition:** An animation that plays when navigating between pages or routes.

**View transition:** A browser or framework transition that morphs between two states or pages, often connecting shared elements.

## Feedback And Interaction

These terms often require `surface-interaction` for the decision and `surface-motion` for implementation.

**Hover effect:** A visual change when the pointer rests over an element.

**Press / tap feedback:** A subtle response when an element is clicked or tapped, commonly a small scale-down.

**Hold to confirm:** A progress effect that fills while the user holds a control.

**Drag:** Moving an element by grabbing it, often with momentum on release.

**Drag to reorder:** Dragging list items to rearrange them while other items move out of the way.

**Swipe to dismiss:** Dragging an element off-screen to close or remove it.

**Rubber-banding:** Resistance and snap-back when a drag moves past a boundary.

**Shake / wiggle:** A quick side-to-side jitter that signals an error or rejected input.

**Ripple:** A circle expanding from the point of a tap to confirm the press.

## Easing

**Easing:** The rate at which an animation speeds up or slows down.

**Ease-out:** Starts fast and ends slow. The default shape for most responsive UI motion.

**Ease-in:** Starts slow and ends fast. Usually avoided for entrances because it can feel sluggish.

**Ease-in-out:** Slow, fast, slow. Useful for elements already on screen moving from A to B.

**Linear:** Constant speed. Avoid for UI transitions; reserve for spinners, marquees, and other constant loops.

**Cubic-bezier:** A custom easing curve for precise timing control.

**Asymmetric easing:** A curve with different acceleration and deceleration shapes. Often feels more alive than a symmetric curve.

## Springs

**Spring:** Physics-based motion driven by tension, mass, and damping rather than a fixed duration.

**Stiffness / tension:** How strongly the spring pulls towards its target. Higher values feel snappier.

**Damping:** How quickly a spring settles. Lower damping allows more bounce and oscillation.

**Mass:** How heavy the animated element feels. More mass makes motion slower and more sluggish.

**Bounce:** Overshoot and settle, usually adding playfulness.

**Perceptual duration:** How long a spring feels like it takes, even though the physics may continue micro-settling.

**Momentum:** Motion that carries velocity, especially after drag or interruption.

**Velocity:** How fast, and in which direction, an element is moving.

**Interruptible animation:** An animation that can smoothly redirect mid-flight instead of finishing first.

## Looping And Ambient Motion

**Marquee:** Text or content scrolling continuously in a loop.

**Loop:** An animation that repeats a fixed number of times or infinitely.

**Alternate / yoyo:** A loop that plays forwards, then reverses each iteration.

**Orbit:** An element circling another element continuously.

**Pulse:** A repeating scale or opacity change used to draw attention.

**Float:** A gentle up-and-down drift that makes a static element feel weightless.

**Idle animation:** Subtle motion that plays while an element is waiting to be interacted with.

## Polish And Effects

**Blur:** A `filter: blur()` effect used to soften an element or mask imperfect transitions.

**Clip-path:** Clipping an element to a shape for reveals, masks, or before/after sliders.

**Mask:** Hiding or revealing part of an element with a shape or gradient, often with soft edges.

**Before / after slider:** A draggable divider that wipes between two overlaid images for comparison.

**Line drawing:** An SVG path drawing itself in, as if traced by a pen.

**Text morph:** Text animating character by character when it changes.

**Skeleton / shimmer:** A placeholder with a moving sheen shown while content loads.

**Number ticker:** Digits rolling or counting up to a value.

**Tabular numbers:** Fixed-width digits that prevent counters, timers, and tickers from shifting as values change.

**Typewriter:** Text appearing one character at a time.

## Performance

**Frame rate (FPS):** Frames drawn per second. 60fps is the smooth-motion baseline; 120fps appears on newer high-refresh displays.

**Jank:** Visible stutter when the browser drops frames.

**Dropped frame:** A frame the browser missed its deadline to draw.

**Compositing:** Letting the GPU move or fade an element on its own layer without rerunning layout or paint.

**will-change:** A CSS hint that an element is about to animate. Use briefly before motion, not permanently on static elements.

**Layout thrashing:** Animating or repeatedly reading and writing layout properties such as `width`, `height`, `top`, or `left`, forcing layout recalculation and causing jank.

## Principles

**Purposeful animation:** Motion should orient, give feedback, show relationships, or clarify state. It should not merely decorate.

**Anticipation:** A small wind-up before a move that hints at what is about to happen.

**Follow-through:** Parts of an element continue moving and settle slightly after the main motion stops.

**Squash and stretch:** Deforming an element as it moves to convey weight, speed, and flexibility.

**Perceived performance:** Motion that makes an interface feel faster or more responsive, even when the underlying work takes the same time.

**Frequency of use:** The more often a user sees an animation, the shorter and subtler it should be.

**Spatial consistency:** Motion that preserves identity and position across states so users do not lose track of where things went.

**Hardware acceleration:** Using `transform` and `opacity` so the GPU can keep motion smooth where possible.

**Reduced motion:** Respecting `prefers-reduced-motion` by toning down or removing non-essential motion while preserving logical state changes.
