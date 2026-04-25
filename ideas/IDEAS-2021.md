# Ideas 2021

Random ideas from 2021 that was added to [n](../README.md) in April 2026.

This was originally a collection of project ideas, small tools, and more... all posted as GitHub issues in its own repo.

> _"Onlookers are welcome to tackle issues found in this repository._
> _Please leave a comment and link to the issue if doing so!_"

The idea was was inspired by [@dtolnay](https://github.com/dtolnay)'s [request-for-implementation](https://github.com/dtolnay/request-for-implementation) repository.

## Cargo `clean` TUI that displays `target` size for detected crates on system and offers to delete clean - Nov 26, 2021

There exist crates that wrap or extend `cargo clean` functionality, but this idea would likely result in a TUI that displays `target` directory size for all crates detected under `$HOME` with the ability to `clean` them individually or in groups.

## GNU/BSD Make replacement with native Windows support (msvc) - Sep 29, 2021

Yes, there's nmake, mage, just, etc., etc. However, It would be nice if GNU/BSD Make _just_ had a _little_ bit more. That is, it would be nice if native Windows support worked.

There's another issue: many Makefiles assume uutils and coreutils will be on the host. Perhaps, this is partially an ecosystem problem. Either way, it would be nice for this issue to be explored further.

## Drone CI Slackbot that posts preview links to builds - Sep 29, 2021

This could be used to track Drone CI build runs rather than opening the site every time.

## Custom Resource Tracing Libary for Kubernetes - Jul 19, 2021

There may be a gap for tracing the lifecycle of CRs for corresponding CRDs in Kubernetes. This library could enable the following:

1. Create a graph of CRs created/updated/deleted over time for a given CRD.
1. What/who created/updated/deleted some CR?

This issue is a little broad, so "tracing" might include pprof/dtrace style flamegraphs or traditional traces. It may also just provide a logger that logs CR create/update/delete events with precise timestamps. The scope is a bit unclear, but the general idea remains.

Origin: debugging CR lifecycles; been thinking about some idea for it for about a year and a half

## Multi-platform CLI font manager - Jul 19, 2021

Fonts can be managed via CLI, but there may be a gap cross-platform option for font installation, perhaps using a lockfile or declarative-file approach to maintaining a list of fonts.

The current landscape:
- macOS: Homebrew casks
- Linux: varies by distro, but some have fonts installable by their default package manager or user repository (PPA/AUR/etc.)
- Windows: unsure at time of writing (haven't researched fully)

The landscape may look like this because some fonts are proprietary, some are open sources, others are only available for downloads on certain sites, etc. The resulting CLI would likely look similar to Homebrew, but specifically tailored to handle font installation on all three major desktop operating system platforms.

Origin: https://twitter.com/bitandbang/status/1417164619790131208

## Multi-platform replacement for the "time" command - Jul 16, 2021

`time` yields results that can be difficult to parse and discern for users new to it. There should be a multi-platform replacement for `time` that works on Windows, is precise, and emphasis on ease of use. It should likely be written in Rust since garbage collection can hinder preciseness.
