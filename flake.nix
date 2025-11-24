{
  description = "A very basic flake (optional)";

  inputs = {
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-unstable"; # or whatever stable branch you prefer
    nixpkgs-qiskit.url = "github:kilianar/nixpkgs/0a4a406a610edd540ae478fb0eb232cee672ab95";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs-stable, nixpkgs-qiskit, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        /*qiskit-pkgs = import nixpkgs-qiskit { inherit system; };

        qiskit-overlay = final: prev: {
          python312 = prev.python312.override {
            packageOverrides = python-final: python-prev: {
              qiskit = qiskit-pkgs.python312.pkgs.qiskit;
            };
          };
        };*/

        pkgs = import nixpkgs-stable {
          inherit system;
          #overlays = [ qiskit-overlay ];
        };

        pythonEnv = pkgs.python312.withPackages (ps: with ps; [
          pip
          #qiskit
        ]);
    in {
      devShells.default = pkgs.mkShell {
        packages = with pkgs; [
          pythonEnv
          stdenv.cc.cc.lib
        ];
        shellHook = ''
          export LD_LIBRARY_PATH="${pkgs.lib.makeLibraryPath [ pkgs.stdenv.cc.cc.lib ]}:$LD_LIBRARY_PATH"
          rebuild-and-activate-venv() {
            echo 'started rebuild-and-activate-venv'
            if [[ -n "$VIRTUAL_ENV" ]]; then
              deactivate
            fi
            rm -rf .venv
            python -m venv .venv 
            # python -m venv --system-site-packages .venv 
            # echo ${pythonEnv}/lib/python3.12/site-packages > .venv/lib/python3.12/site-packages/system.pth
            source .venv/bin/activate
            echo 'finished rebuild-and-activate-venv'
          }
          ipykernel-install() {
            pip install ipykernel
            python -m ipykernel install --user --name=playground
          }
          jn() {
            # jupyter executable from the system
            jupyter notebook
          }
          jl() {
            # jupyter executable from the system
            jupyter lab
          }
          PS1="\\n\\[\\033[33m\\][playground:\\w]\$ \\[\\033[0m\\]"
          echo ""
          echo 'press Ctrl+D to exit'
          if [ ! -d ".venv" ]; then 
            rebuild-and-activate-venv
          else
            source .venv/bin/activate
          fi
        '';
      };
    }
  );
}
