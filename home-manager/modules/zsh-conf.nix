{...}: {
  home.sessionPath = [
   "$HOME/.cargo/bin"
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    completionInit = "autoload -U compinit && compinit -u";
    # zprof.enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    history = {
      path = "$HOME/.histfile";
      size = 500;
      save = 1000;
    };

    sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
      docker = "podman";

      CHROME_EXECUTABLE = "/usr/bin/chromium";
    };

    shellAliases = {
      docker-compose = "podman-compose";
      ls = "eza --icons -lah";
      cat = "bat";
      cd = "z";
    };

    initContent = ''
      bindkey -e

      setopt extendedglob
      setopt notify

      # Sourcing Matugen fzf theme if present
      [ -f "$HOME/.config/fzf/fzf-matugen.zsh" ] && . "$HOME/.config/fzf/fzf-matugen.zsh"

      [ -f "$HOME/.local/bin/env" ] && . "$HOME/.local/bin/env"
    '';
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;

    settings = {
      "$schema" = "https://starship.rs/config-schema.json";

      palette = "earthy";

      palettes.earthy = {
        blue = "#A68C8A";
        red = "#40170E";
        green = "#594347";
        yellow = "#D9CCCC";
        cyan = "#A68C8A";
        magenta = "#594347";
        white = "#D9CCCC";
        black = "#0D0D0D";

        rosewater = "#D9CCCC";
        flamingo = "#A68C8A";
        pink = "#594347";
        mauve = "#40170E";
        maroon = "#40170E";
        peach = "#D9CCCC";
        teal = "#594347";
        sky = "#A68C8A";
        sapphire = "#594347";
        lavender = "#40170E";

        text = "#D9CCCC";
        subtext1 = "#A68C8A";
        subtext0 = "#594347";

        overlay2 = "#594347";
        overlay1 = "#A68C8A";
        overlay0 = "#40170E";
        surface2 = "#40170E";
        surface1 = "#0D0D0D";
        surface0 = "#0D0D0D";
        base = "#0D0D0D";
        mantle = "#0D0D0D";
        crust = "#40170E";
      };

      character = {
        success_symbol = "[❯](bold green)";
        error_symbol = "[❯](bold red)";
        vicmd_symbol = "[❮](bold blue)";
      };

      custom.latex = {
        detect_extensions = [
          "tex"
          "sty"
          "cls"
          "bib"
        ];
        detect_files = [
          "latexmkrc"
          "latexmkrc"
        ];
        symbol = "📝 ";
        format = "[$symbol]($style)";
      };

      bun.format = "via []($style)";
      buf.format = "with [⎈]($style)";
      c.format = "via []($style)";
      cmake.format = "via [⚙️]($style)";
      cobol.format = "via [⚙️]($style)";
      cpp.format = "via []($style)";
      crystal.format = "via []($style)";
      daml.format = "via [⚖️]($style)";
      dart.format = "via []($style)";
      deno.format = "via []($style)";
      dotnet.format = "[$symbol(🎯 $tfm )]($style)";
      elixir.format = "via []($style)";
      elm.format = "via []($style)";
      erlang.format = "via []($style)";
      fennel.format = "via []($style)";
      fortran.format = "via []($style)";
      gleam.format = "via []($style)";
      golang.format = "via []($style)";
      gradle.format = "via []($style)";
      haskell.format = "via []($style)";
      haxe.format = "via []($style)";
      helm.format = "via [⎈]($style)";
      java.format = "via []($style)";
      julia.format = "via []($style)";
      kotlin.format = "via []($style)";
      lua.format = "via []($style)";
      maven.format = "via []($style)";
      meson.format = "via [⚙️]($style)";
      mojo.format = "with [🔥]($style)";
      nim.format = "via [🐍]($style)";
      nodejs.format = "via []($style)";
      ocaml.format = "via [$symbol(\\($switch_indicator$switch_name\\) )]($style)";
      odin.format = "via [☸️]($style)";
      opa.format = "via [⚙️]($style)";
      perl.format = "via []($style)";
      php.format = "via []($style)";
      pixi.format = "via [$symbol($environment )]($style)";
      pulumi.format = "via [$symbol$stack]($style)";
      purescript.format = "via []($style)";
      python.format = "via []($style)";
      quarto.format = "via [📊]($style)";
      raku.format = "via [🦋]($style)";
      red.format = "via [🔴]($style)";
      rlang.format = "via [📐]($style)";
      ruby.format = "via []($style)";
      rust.format = "via []($style)";
      scala.format = "via []($style)";
      solidity.format = "via [🔗]($style)";
      swift.format = "via [🐦]($style)";
      typst.format = "via [📝]($style)";
      vagrant.format = "via [📦]($style)";
      vlang.format = "via [🌐]($style)";
      xmake.format = "via [⚙️]($style)";
      zig.format = "via [⚡]($style)";

      package = {
        format = "[$symbol$version]($style)";
        symbol = "📦 ";
      };
    };
  };

  programs.eza = {
    enable = true;
    enableZshIntegration = true;
    git = true;
    icons = "auto";
  };
}
