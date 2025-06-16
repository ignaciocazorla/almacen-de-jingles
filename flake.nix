{
    inputs = {
        ihp.url = "github:digitallyinduced/ihp/v1.3";
        nixpkgs.follows = "ihp/nixpkgs";
        flake-parts.follows = "ihp/flake-parts";
        devenv.follows = "ihp/devenv";
        systems.follows = "ihp/systems";
    };

    outputs = inputs@{ self, nixpkgs, ihp, flake-parts, systems, ... }:
        flake-parts.lib.mkFlake { inherit inputs; } {

            systems = import systems;
            imports = [ ihp.flakeModules.default ];

            perSystem = { pkgs, ... }: {
                ihp = {
                    # appName = "app"; # Available with v1.4 or latest master
                    enable = true;
                    projectPath = ./.;
                    packages = with pkgs; [
                        # Native dependencies, e.g. imagemagick
                    ];
                    haskellPackages = p: with p; [
                        # Haskell dependencies go here
                        p.ihp
                        cabal-install
                        base
                        wai
                        text

                        # Uncomment on local development for testing
                        # hspec
                    ];
                };

                # Custom configuration that will start with `devenv up`
                devenv.shells.default = {
                    # Start Mailhog on local development to catch outgoing emails
                    # services.mailhog.enable = true;

                    # Custom processes that don't appear in https://devenv.sh/reference/options/
                    processes = {
                        # Uncomment if you use tailwindcss.
                        # tailwind.exec = "tailwindcss -c tailwind/tailwind.config.js -i ./tailwind/app.css -o static/app.css --watch=always";
                        
                        # Running InitializeApp.hs script
                        init-app.exec = "./Application/Script/InitializeApp.hs";
                    };
                };
            };
        };
}
