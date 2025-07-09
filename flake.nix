{
  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = inputs @ {flake-parts, ...}:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = ["x86_64-linux"];
      perSystem = {
        config,
        self',
        inputs',
        pkgs,
        lib,
        system,
        ...
      }: {
        devShells.default = pkgs.mkShellNoCC {
          buildInputs = with pkgs; [just godot_4];
          shellHook = ''
            printf "\n\033[0;37m\033[44m GODOT \033[0m \033[0;36mType '\033[1;36mjust edit\033[0;36m' to get started!\033[0m\n\n"
            just --list
            printf "\n"
          '';
        };

        packages.default = pkgs.stdenvNoCC.mkDerivation {
          name = "flappyclone";
          version = "0.0.1";

          src = ./.;

          strictDeps = true;

          nativeBuildInputs = with pkgs; [
            autoPatchelfHook
            godot_4
          ];

          runtimeDependencies = with pkgs; [
            alsa-lib
            libGL
            libpulseaudio
            xorg.libX11
            xorg.libXcursor
            xorg.libXext
            xorg.libXi
            xorg.libXrandr
            udev
            vulkan-loader
          ];

          buildPhase = ''
            runHook preBuild
          
            # Cannot create file '/homeless-shelter/.config/godot/projects/...'
            export HOME=$TMPDIR

            # Copy over export templates
            mkdir -p $HOME/.local/share/godot/export_templates
            ln -s "${pkgs.godot_4-export-templates}" "$HOME/.local/share/godot/export_templates/${lib.replaceStrings [ "-" ] [ "." ] pkgs.godot_4.version}"
            mkdir -p build

            # Compile
            godot4 --headless --export-release "Linux" ./build/game

            runHook postBuild
          '';

          installPhase = ''
            install -D -m 755 -t $out ./build/game
          '';
        };
        
        formatter = pkgs.alejandra;
      };
    };
}
