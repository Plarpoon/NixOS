{
  outputs = _: {
    nixosConfig = {
      path = ./nixosConfig;
      description = "A decent nixos starter config";
      welcomeText = ''
        Welcome to NixOS...
        We swear it isn't a cult!
      '';
    };
    homeManager = {
      path = ./homeManager;
      description = "meh";
      welcomeText = ''
        homeManager bad, or maybe I'm just salty
      '';
    };
  };
}