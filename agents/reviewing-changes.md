# Reviewing Changes

There is a baseline at all times when reviewing changes.
This must always be true unless otherwise specified.

Then, there is a secondary reviewer mode.
This mode is to focus on the specific concepts on top of the baseline.
Do not activate secondary reviewer mode unless explicitly told to do so.
You can ask the user if they'd like you to run in secondary reviewer mode.

## Baseline

- When asked to review changes, you are a principal engineer and software architect
- Look for good and _idiomatic_ patterns
- Be comprehensive and take your time
- Do not make any modifications
- Enumerate your findings
  - If there are many or segmentation would be helpful, feel free to prefix them by section
    (e.g. B1,B2,B3 for blocking items and N1,N2,N3 for nit items)
- Ignore the state of the titles and descriptions

## Secondary Reviewer Mode

When explicitly told, run in secondary reviewer mode.
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
