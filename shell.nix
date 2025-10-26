{pkgs ? import <nixpkgs> {}}:
pkgs.mkShell {
  allowUnfree = true;
  name = "h4rl's nvim configuration";
  packages = with pkgs; [
    zsh
    stylua
    lua-language-server
    luajit
    luajitPackages.luacheck

    cbfmt
  ];
}
