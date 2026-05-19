{
  security = {
    sudo.wheelNeedsPassword = false;
    pam.services = {
      login.enableGnomeKeyring = true;
      lightdm.enableGnomeKeyring = true;
    };
  };
}
