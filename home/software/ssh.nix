{
  config,
  lib,
  pkgs,
  ...
}:

{
  programs.ssh = {
    enable = true;
    # 1Password SSH Agent
    # extraConfig = ''
    #   Host *
    #       IdentityAgent ~/.1password/agent.sock
    # '';
    matchBlocks."*".identityAgent = "~/.1password/agent.sock";
  };
}
