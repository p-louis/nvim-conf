{ pkgs,
  ...
}:

pkgs.stdenv.mkDerivation rec {
  pname = "kotlin-lsp";
  version = "0.253.10629";
  src = pkgs.fetchzip {
    stripRoot = false;
    url = "https://download-cdn.jetbrains.com/kotlin-lsp/${version}/kotlin-${version}.zip";
    hash = "sha256-LCLGo3Q8/4TYI7z50UdXAbtPNgzFYtmUY/kzo2JCln0=";
  };

  dontBuild = true;

  installPhase = ''
    mkdir -p $out/lib
    mkdir -p $out/native
    mkdir -p $out/bin
    cp -r lib/* $out/lib
    ls -la
    cp -r native/* $out/native
    chmod +x kotlin-lsp.sh
    cp "kotlin-lsp.sh" "$out/kotlin-lsp"
    ln -s $out/kotlin-lsp $out/bin/kotlin-lsp
  '';

  nativeBuildInputs = [
    pkgs.gradle
    pkgs.makeWrapper
  ];
  buildInputs = [
    pkgs.openjdk
    pkgs.gradle
  ];

  postFixup = ''
    wrapProgram "$out/bin/kotlin-lsp" --set JAVA_HOME ${pkgs.openjdk} --prefix PATH : ${
      pkgs.lib.strings.makeBinPath [
        pkgs.openjdk
        pkgs.maven
      ]
    }
  '';

  meta = {
    description = "Kotlin LSP";
    longDescription = ''
      Official LSP implementation for Kotlin code completion, linting and more
      for any editor/IDE'';
    maintainers = with pkgs.lib.maintainers; [ p-louis ];
    homepage = "https://github.com/Kotlin/kotlin-lsp";
    changelog = "https://github.com/Kotlin/kotlin-lsp/blob/main/RELEASES.md";
    license = pkgs.lib.licenses.asl20;
    platforms = pkgs.lib.platforms.unix;
    sourceProvenance = [ pkgs.lib.sourceTypes.binaryBytecode ];
    mainProgram = "kotlin-lsp";
  };
}
