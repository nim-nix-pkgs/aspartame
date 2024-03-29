{
  description = ''More syntactic sugar for Nim'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs."aspartame-master".dir   = "master";
  inputs."aspartame-master".owner = "nim-nix-pkgs";
  inputs."aspartame-master".ref   = "master";
  inputs."aspartame-master".repo  = "aspartame";
  inputs."aspartame-master".type  = "github";
  inputs."aspartame-master".inputs.nixpkgs.follows = "nixpkgs";
  inputs."aspartame-master".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@inputs:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib"];
  in lib.mkProjectOutput {
    inherit self nixpkgs;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
    refs = builtins.removeAttrs inputs args;
  };
}