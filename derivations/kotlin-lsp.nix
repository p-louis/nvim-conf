{
  lib,
  stdenv,
  fetchzip,
  makeWrapper,
}:

stdenv.mkDerivation rec {
  pname = "kotlin-lsp";
  version = "261.13587.0";
  platformSuffix = lib.attrByPath [ stdenv.hostPlatform.system ] (throw "unsupported platform: ${stdenv.hostPlatform.system}") {
    "x86_64-linux"  = "linux-x64";
    "aarch64-linux" = "linux-aarch64";
    "x86_64-darwin"  = "macos-x64";
    "aarch64-darwin" = "macos-aarch64";
  };

  hashes = {
    "x86_64-linux"  = "sha256-dc0ed2e70cb0d61fdabb26aefce8299b7a75c0dcfffb9413715e92caec6e83ec";
    "aarch64-linux" = "sha256-d1dceb000fe06c5e2c30b95e7f4ab01d05101bd03ed448167feeb544a9f1d651";
    "x86_64-darwin"  =  "sha256-a3972f27229eba2c226060e54baea1c958c82c326dfc971bf53f72a74d0564a3";
    "aarch64-darwin" =  "sha256-d4ea28b22b29cf906fe16d23698a8468f11646a6a66dcb15584f306aaefbee6c";
  };

  src = fetchzip {
    stripRoot = false;
    url = "https://download-cdn.jetbrains.com/kotlin-lsp/${version}/kotlin-lsp-${version}-${platformSuffix.${stdenv.hostPlatform.system}}.zip";
    hash = hashes.${stdenv.hostPlatform.system};
  };

  dontBuild = true;

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin $out/lib/kotlin-lsp
    cp * $out/lib/kotlin-lsp
    ln -s $out/lib/kotlin-lsp/kotlin-lsp.sh $out/bin/kotlin-lsp

    runHook postInstall
  '';

  nativeBuildInputs = [
    makeWrapper
  ];

  meta = {
    description = "LSP implementation for Kotlin code completion, linting";
    maintainers = with lib.maintainers; [ p-louis ];
    homepage = "https://github.com/Kotlin/kotlin-lsp";
    changelog = "https://github.com/Kotlin/kotlin-lsp/blob/kotlin-lsp/v${version}/RELEASES.md";
    license = lib.licenses.asl20;
    platforms = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
    sourceProvenance = [ lib.sourceTypes.binaryBytecode ];
    mainProgram = "kotlin-lsp";
  };
}
