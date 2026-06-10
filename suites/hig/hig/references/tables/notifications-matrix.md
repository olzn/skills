<!-- hig-snapshot: 2026-06-10 · baseline: iOS 26.x / macOS 26.x · src: managing-notifications -->

# Notification interruption levels and marketing rules

Permission is required before sending ANY notification. Two classes: **communication notifications** (direct person-to-person calls/messages — adopt SiriKit intents such as `INSendMessageIntent`; alert timing is determined by the sender) and **noncommunication notifications** (everything else — you must assign one of four interruption levels). <!-- src: managing-notifications -->

## Behaviour matrix (verbatim HIG)
| Interruption level | Overrides scheduled delivery | Breaks through Focus | Overrides Ring/Silent switch (iPhone/iPad) |
|---|---|---|---|
| Passive | No | No | No |
| Active (default) | No | No | No |
| Time Sensitive | Yes | Yes | No |
| Critical | Yes | Yes | Yes |
<!-- src: managing-notifications -->

## Level definitions
| Level | Definition | Example |
|---|---|---|
| Passive | viewable at leisure | restaurant recommendation |
| Active (default) | appreciated on arrival | sports score update |
| Time Sensitive | directly impacts the person, requires immediate attention — only for events happening now or within an hour | account security issue, package delivery |
| Critical | urgent health/safety, extremely rare; **requires an entitlement** | typically governmental/public agencies or health/home apps |
<!-- src: managing-notifications -->

Notes:
- A notification delayed by Focus or scheduled delivery is still available in Notification Center as soon as it arrives — only the alert is delayed. <!-- src: managing-notifications -->
- Accurately represent urgency: the system explains Time Sensitive on first use and periodically offers to turn it off for your app; misclassification trains people to disable your notifications. <!-- src: managing-notifications -->
- The Ring/Silent column applies to iPhone/iPad only; macOS has no equivalent, and macOS notification sounds mix with other audio by default. The HIG still says "Ring/Silent switch" although recent iPhones use the Action button — keep Apple's terminology. <!-- src: managing-notifications, playing-audio -->

## Marketing notifications — tier 1, App Review-relevant
| # | Rule (HIG "you must" language) |
|---|---|
| 1 | Don't send marketing/promotional content unless people explicitly agree to receive it |
| 2 | Never use Time Sensitive for marketing |
| 3 | Get explicit opt-in via an alert/modal/interface describing what you'll send, AND provide an in-app settings screen where people can change the choice |
<!-- src: managing-notifications -->

Hard fails (reviewer): marketing/promo notification without separate explicit opt-in UI plus an in-app notification-settings screen · Time Sensitive on non-immediate content (sales, digests) · Critical level in a non-health/safety app · notifications sent before permission is granted. <!-- src: managing-notifications -->

Scope note: this page owns consent, Focus and interruption levels. Anatomy, content writing, actions and badging live on the `notifications` component page — don't conflate. <!-- src: managing-notifications -->
