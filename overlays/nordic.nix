_final: prev: let
  inherit (prev) fetchFromGitHub;
in {
  nordic = prev.nordic.overrideAttrs (_old: {
    version = "unstable-2022-06-29";
    srcs = [
      (fetchFromGitHub {
        owner = "EliverLara";
        repo = "Nordic";
        rev = "v2.2.0";
        sha256 = "sha256-wTWHdao/1RLqUmqh/9gEyhERGymFWHqiC97JD28LSgk=";
        name = "Nordic";
      })

      (fetchFromGitHub {
        owner = "EliverLara";
        repo = "Nordic";
        rev = "v2.2.0";
        sha256 = "sha256-wTWHdao/1RLqUmqh/9gEyhERGymFWHqiC97JD28LSgk=";
        name = "Nordic-standard-buttons";
      })

      (fetchFromGitHub {
        owner = "EliverLara";
        repo = "Nordic";
        rev = "v2.2.0";
        sha256 = "sha256-wTWHdao/1RLqUmqh/9gEyhERGymFWHqiC97JD28LSgk=";
        name = "Nordic-darker";
      })

      (fetchFromGitHub {
        owner = "EliverLara";
        repo = "Nordic";
        rev = "v2.2.0";
        sha256 = "sha256-wTWHdao/1RLqUmqh/9gEyhERGymFWHqiC97JD28LSgk=";
        name = "Nordic-darker-standard-buttons";
      })

      (fetchFromGitHub {
        owner = "EliverLara";
        repo = "Nordic";
        rev = "v2.2.0";
        sha256 = "sha256-wTWHdao/1RLqUmqh/9gEyhERGymFWHqiC97JD28LSgk=";
        name = "Nordic-bluish-accent";
      })

      (fetchFromGitHub {
        owner = "EliverLara";
        repo = "Nordic";
        rev = "v2.2.0";
        sha256 = "sha256-wTWHdao/1RLqUmqh/9gEyhERGymFWHqiC97JD28LSgk=";
        name = "Nordic-bluish-accent-standard-buttons";
      })

      (fetchFromGitHub {
        owner = "EliverLara";
        repo = "Nordic";
        rev = "v2.2.0";
        sha256 = "sha256-wTWHdao/1RLqUmqh/9gEyhERGymFWHqiC97JD28LSgk=";
        name = "Nordic-Polar";
      })

      (fetchFromGitHub {
        owner = "EliverLara";
        repo = "Nordic";
        rev = "v2.2.0";
        sha256 = "sha256-wTWHdao/1RLqUmqh/9gEyhERGymFWHqiC97JD28LSgk=";
        name = "Nordic-Polar-standard-buttons";
      })
    ];
  });
}
