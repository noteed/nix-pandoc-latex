let

  # `nix/sources.json` defines our Nix dependencies. We use it to select a
  # specific version of `nixpkgs`.
  sources = import ./nix/sources.nix;

  # We import `nixpkgs`. It is customary to name the result `pkgs`.
  pkgs = import sources.nixpkgs { };

  # For latex, we define our own set of packages using the `combine` function.
  # We could also use a predefined set, such as
  # `pkgs.texlive.combined.scheme-basic`, instead.
  tex = pkgs.texlive.combine {
    inherit (pkgs.texlive)
      etoolbox
      scheme-basic
      xcolor
      # We can add more packages here, e.g. `titlesec`.
      ;
  };

in

# `runCommand` is a helper function to define a Nix derivation. Nix offers
# a lof of those. They all end-up calling the primitive mechanism,
# `pkgs.stdenv.mkDerivation`.
# `"hello"` is a name to help us distinguish paths in the Nix store; in
#  our case, `/nix/store/vq5xv8i31gbr7mflb00jmmfxkljf29ck-hello`.
pkgs.runCommand "hello" {
  # Our texlive dependency doesn't appear explicitely in the below script,
  # so we explicitely reference it here.
  buildInputs = [ tex ];

  # We define a variable to refer to our input file.
  input = ./hello.md;

  # The second argument of `runCommand` is a string. Here we use the double
  # single quote syntax to write a multi-line string.
} ''
  # The goal of the script is to create a Nix store path. `$out` contains
  # the path we need to create. In this case, we decide to make it a directory.
  # We could also generate our resulting PDF directly there, without wrapping
  # it in a directory.
  mkdir $out

  # While we had to reference `tex` above, here we reference `pkgs.pandoc`
  # in the script. Nix thus knows it depends on Pandoc and we don't need
  # to add manually Pandoc to `buildInputs` as we did for `tex`.
  ${pkgs.pandoc}/bin/pandoc \
    -s \
    -V geometry:a4paper \
    -o $out/hello.pdf \
    $input
''
