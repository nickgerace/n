# Reviewing Changes

The baseline below applies to every review unless the user says otherwise.
Reviewer modes add a focus on top of the baseline.
Activate a mode only when explicitly told to; you may ask the user whether to run one or more modes.

## Baseline

- Look for good and _idiomatic_ patterns
- Review the entire change, not a sample of it
- Do not make any modifications
- Enumerate your findings, and if there are many findings or segmentation of them would be helpful,
  feel free to prefix them by section (examples below)
  - B1,B2,B3,BX for blocking items
  - R1,R2,R3,RX for recommended items
  - N1,N2,N3,NX for nit items
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
