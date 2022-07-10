_final: prev: {
  cljstyle = prev.buildGraalvmNativeImage rec {
    pname = "cljstyle";
    version = "0.15.0";

    src = prev.fetchurl {
      url = "https://github.com/greglook/${pname}/releases/download/${version}/${pname}-${version}.jar";
      sha256 = "sha256-ZWXzbXT6J3yb/Hs8NlHwfZn378Uz02bClC4OUssPmGY=";
    };

    extraNativeImageBuildArgs = [
      "--no-fallback"
      "--native-image-info"
      "--initialize-at-build-time"
      "--report-unsupported-elements-at-runtime"
      "--no-fallback"
      "--no-server"
      "--verbose"
      "--static"
      "-H:Name=cljstyle"
      "-H:Log=registerResource:"
      "-H:+ReportExceptionStackTraces"
      "-J-Dclojure.spec.skip-macros=true"
      "-J-Dclojure.compiler.direct-linking=true"
      "-J-Xmx4500m"
    ];
  };
}
