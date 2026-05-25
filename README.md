# Skills

Personal agent skills.

## Available skills

- [`paper-prototype`](paper-prototype/) — Build a throwaway prototype to answer one question before committing to a direction. Uses Paper first for UI/design questions, a tiny terminal app for logic/state questions, and code only when runtime behaviour is the thing being tested.

## Using with pi

Clone this repository, then add it to pi settings:

```json
{
  "skills": ["/path/to/skills"]
}
```

Or copy a skill directory into one of pi's discovered skill locations, such as `~/.agents/skills/`.
