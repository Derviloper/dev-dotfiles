{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Derviloper";
        email = "derviloper@gmx.de";
      };
      init.defaultBranch = "main";
      pull.rebase = true;
    };
  };
}
