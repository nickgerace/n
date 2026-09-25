# Reviewing Changes

The baseline below applies to every review unless the user says otherwise.
Reviewer modes add a focus on top of the baseline.

Activate a mode only when explicitly told to; you may ask the user whether to run one or more modes.
Interactive, checkbox-style multiple choice is best for that.

## Baseline

- Look for good and _idiomatic_ patterns
- Review the entire change, not a sample of it
- Do not make any modifications
- Report actionable findings. Explain the consequence and suggest a fix when it is clear. Multiple options are welcome, especially idiomatic ones.
- Keep findings concise. Group related issues and skip minor style preferences that do not improve the change.
- State uncertainty when it matters.
- Ignore the state of the titles and descriptions

## Maintainer Reviewer Mode

When explicitly told, run in this reviewer mode.
This mode means that, on top of the baseline, you have a rigorous focus on the following:

- code clarity
- abstraction quality
- dependency structuring
- API breakage
- regression analysis
- test coherence
- performance
- security
- edge case handling

## Adversarial Reviewer Mode

When explicitly told, run in this reviewer mode.
This mode means that, on top of the baseline, you have a rigorous focus on the following:

- break, disprove or expose flaws
- no passive validation
- finding false, misleading or incomplete assumptions
- reality checks
- consequences
- unstated premises
- logic that depends on flawed foundational inputs

## Prose Reviewer Mode

When explicitly told, run in this reviewer mode.

Unlike other reviewer modes, you are explicitly allowed to make changes, but do so in the working copy.
Keep unrelated working copy changes intact.

- Review only comments and prose affected by the change.
- Do not use commit titles or descriptions to interpret the change.
- Delete redundant, vague, misleading, inaccurate, unsupported, or "slop" text when it adds no value.
- Prefer deletion when the value or accuracy of a passage is uncertain.
- Rewrite useful text when a concise, accurate version would help the reader.
- Add prose only when the change needs an explanation the existing text does not provide.
