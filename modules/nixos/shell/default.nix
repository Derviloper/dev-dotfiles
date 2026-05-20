{ pkgs, ... }:
{
  # Done here and not in home-manager because it should also be used in root user
  programs.zsh = {
    enable = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    interactiveShellInit = ''
      source ${pkgs.unstable.fzf}/share/fzf/key-bindings.zsh
      source ${pkgs.unstable.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
      if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
        source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
      fi
      source /etc/p10k.zsh
    '';
  };

  environment.etc."p10k.zsh".source = ./p10k.zsh;

  users.defaultUserShell = pkgs.unstable.zsh;

  home-manager.sharedModules = [ { home.file.".zshrc".text = ""; } ];
}
