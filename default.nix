with import <nixpkgs> {};

runCommandNoCC "longest-non-unique" {
  nativeBuildInputs = [
    (haskellPackages.ghcWithPackages (p: [
      p.text
      p.unordered-containers
    ]))
  ];
} ''
  mkdir -p $out/bin
  ghc ${./Main.hs} -o $out/bin/longest-non-unique
''
