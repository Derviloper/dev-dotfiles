{ config, pkgs, pkgsUnstable, ... }: {
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    plugins = [{
      name = "powerlevel10k";
      src = "${pkgsUnstable.zsh-powerlevel10k}/share/zsh-powerlevel10k";
      file = "powerlevel10k.zsh-theme";
    }];
    initContent = ''
      source ${pkgsUnstable.fzf}/share/fzf/key-bindings.zsh
      [[ -r "$HOME/.p10k.zsh" ]] && source "$HOME/.p10k.zsh"
    '';
  };

  home.file.".p10k.zsh".source =
    config.lib.file.mkOutOfStoreSymlink
      "${config.home.homeDirectory}/Projects/dotfiles/p10k.zsh";
}
