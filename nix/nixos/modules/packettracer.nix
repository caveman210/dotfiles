{
  pkgs,
  lib,
  ...
}: let
  version = "9.0.1";
  pname = "cisco-packet-tracer";

  # Extract the AppImage from the local Cisco DEB.
  packetTracerAppImage = pkgs.stdenvNoCC.mkDerivation {
    pname = "${pname}-appimage";
    inherit version;

    src = ../binaries/CiscoPacketTracer_901_Ubuntu_64bit.deb;

    nativeBuildInputs = [
      pkgs.dpkg
    ];

    dontUnpack = true;

    installPhase = ''
      runHook preInstall

      dpkg-deb --extract "$src" deb

      install -Dm755 \
        deb/opt/pt/packettracer.AppImage \
        "$out"

      runHook postInstall
    '';
  };

  # Wrap the extracted AppImage using Nixpkgs tooling.
  packetTracer = pkgs.appimageTools.wrapType2 rec {
    inherit pname version;

    src = packetTracerAppImage;

    extraPkgs = _: [
      pkgs.libpng
      pkgs.libxkbfile
    ];

    extraBwrapArgs = [
      "--setenv QT_QPA_PLATFORM xcb"
    ];

    extraInstallCommands = let
      contents = pkgs.appimageTools.extract {
        inherit pname version;
        src = packetTracerAppImage;
      };
    in ''
      mv "$out/bin/${pname}" "$out/bin/packettracer9"

      install -Dm444 \
        ${contents}/CiscoPacketTracer-9.0.1.desktop \
        "$out/share/applications/cisco-packet-tracer-9.desktop"

      install -Dm444 \
        ${contents}/CiscoPacketTracerPtsa-9.0.1.desktop \
        "$out/share/applications/cisco-packet-tracer-ptsa-9.desktop"

      substituteInPlace "$out/share/applications/"*.desktop \
        --replace-fail "Exec=@EXEC_PATH@" "Exec=packettracer9" \
        --replace-fail "Icon=app" "Icon=cisco-packet-tracer-9"

      install -Dm444 \
        ${contents}/usr/share/icons/hicolor/48x48/apps/app.png \
        "$out/share/icons/hicolor/48x48/apps/cisco-packet-tracer-9.png"

      cp -r \
        ${contents}/usr/share/icons/gnome/48x48/mimetypes \
        "$out/share/icons/hicolor/48x48/"

      cp -r ${contents}/usr/share/mime "$out/share/"

      for desktop in "$out"/share/applications/*.desktop; do
        sed -i '/^\[Desktop Entry\]/a StartupWMClass=PacketTracer' "$desktop"
      done
    '';

    meta = {
      description = "Cisco Packet Tracer 9";
      homepage = "https://www.netacad.com/courses/packet-tracer";
      license = lib.licenses.unfree;
      platforms = ["x86_64-linux"];
      mainProgram = "packettracer9";
    };
  };
in {
  programs.firejail = {
    enable = true;

    wrappedBinaries.packettracer9 = {
      executable = lib.getExe packetTracer;

      desktop = "${packetTracer}/share/applications/cisco-packet-tracer-9.desktop";

      extraArgs = [
        "--net=none"
        "--noprofile"
        "--env=QT_STYLE_OVERRIDE="
      ];
    };
  };
}
