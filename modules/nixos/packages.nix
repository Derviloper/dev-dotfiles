{ pkgs, pkgsUnstable, ... }:

{
  environment = {
    systemPackages = with pkgsUnstable; [
      fzf
      zsh-powerlevel10k
      ghostty

      brave

      gcc

      (symlinkJoin {
        name = "python311";
        paths = [ python311 ];
        buildInputs = [ pkgs.makeWrapper ];
        postBuild = ''
          wrapProgram "$out/bin/python3.11" \
            --run 'export LD_LIBRARY_PATH=$NIX_LD_LIBRARY_PATH'
        '';
      })

      (symlinkJoin {
        name = "cargo";
        paths = [ cargo ];
        buildInputs = [ pkgs.makeWrapper ];
        postBuild = ''
          wrapProgram "$out/bin/cargo" \
            --run 'export LD_LIBRARY_PATH=$NIX_LD_LIBRARY_PATH'
        '';
      })
      rustc
      rustfmt
      clippy
      rust-analyzer
      rust.packages.stable.rustPlatform.rustLibSrc
    ];

    variables = {
      RUST_SRC_PATH = "${pkgsUnstable.rust.packages.stable.rustPlatform.rustLibSrc}";
    };
  };
}
