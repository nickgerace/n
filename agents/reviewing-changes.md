# Reviewing Changes

The baseline below applies to every review unless the user says otherwise.
Reviewer modes add a focus on top of the baseline.

Activate a mode only when explicitly told to; you may ask the user whether to run one or more modes.
Interactive, checkbox-style multiple choice is best for that.

## Baseline

- Look for good and _idiomatic_ patterns
- Review the entire change, not a sample of it
- Do not make any modifications
- Enumerate your findings, and if there are many findings or segmentation of them would be helpful,
  feel free to prefix them by section (examples below)
  - B1,B2,B3,BX for blocking items
  - R1,R2,R3,RX for recommended items
  - N1,N2,N3,NX for nit items
- For each enumerated finding, give a confidence level with the following choices: very high, high,
  medium, low, very low
- Reference each finding by file path and line number so it can be located quickly
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
If the working copy is unclean, ask to create another working copy.

- Review only comments and prose affected by the change.
- Do not use commit titles or descriptions to interpret the change.
- Recommend deleting comments and prose that are "slop", redundant, vague, misleading, inaccurate or unsupported
- Default to deletion when the value or accuracy of a passage is uncertain
- Modify only when you are highly confident it will be accurate, concise, and human readable
- Prune slop and default to deletion
