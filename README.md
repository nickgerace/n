# Dotfiles

My dotfiles and configurations.

## Quickstart

Before starting, ensure that you have `bash`, `just` and `nu` installed on your macOS or Linux system.

> [!TIP]
> If you are on macOS, have `brew` installed and choose to install packages during installation, you do not need to have `nu` installed.
> It will be installed during setup via `brew`.

You will also need to ensure that this repository resides in the `$HOME/src/` directory.
You may need to create it by executing `mkdir $HOME/src`.

> [!WARNING]
> Running the following command may overwrite files if you are coming from an existing configuration.
> Please read the source code, starting from the [justfile](justfile), before executing the recipe.

Once everything looks good, run the installer.
By default, it will only install dotfiles and load configurations based on them.
Depending on your platform, you may be presented with an option to install packages and perform additional setup.
That is entirely optional.

```shell
just install
```

The invoked `just` recipe runs an idempotent-ish bootstrap script, so you should be able to execute it multiple times.
That being said: *caution is advised*.

## Updating

Once the initial `just` recipe is ran, you can update packages and more using the `update` recipe.

```shell
just update
```

If you reload your shell, you can use the provided alias that runs the same script under the hood.
This is the primary method for updating packages.

```shell
update
```

> [!NOTE]
> The underlying update script only updates packages with the current dotfiles in place.
> If there are new or deleted dotfiles, you will need to run the installer again (i.e. `just install`).

## Changing Theme

If the theme is changed, the configurations for `fastfetch`, `ghostty`, `helix` and `nu` likely will need to be changed.
The theme for `mise` can likely remain the same, but should be checked too.

There are other tools affected by the theme, but they derive their colors through other configurations, such as `LS_COLORS`.
In fact, the `LS_COLORS` environment variable is set in the `nu` configuration.

## Disclaimer

Files not recently in use may be out of date.
This is a "living" repository, meaning that scripts and dotfiles more frequently in use will be more likely to be kept up to date.
Anything not recently or frequently in use will be removed from the repository (eventually).
