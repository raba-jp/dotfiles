{pkgs, ...}: {
  programs.waybar = {
    enable = true;
    # systemd.enable = true;

    settings = [
      {
        module-left = [
          "wlr/taskbar"
        ];
        module-right = [
          "pulseaudio"
          "custom/separator"
          "network"
          "custom/separator"
          "clock"
          "tray"
        ];

        tray = {
          spacing = 10;
        };

        clock = {
          format = "{:%I:%M %p}";
          format-alt = "{:%D}";
        };

        "custom/separator" = {
          format = "";
        };

        pulseaudio = {
          format = "{icon} {volume}% {format_source}";
          format-bluetooth = "{icon} {format_source}";
          format-bluetooth-muted = " {icon} 0% {format_source}";
          format-muted = " 0% {format_source}";
          format-source = "  {volume}%";
          format-source-muted = "  0%";
          format-icons = {
            headphone = "";
            hands-free = "蓼";
            headset = "蓼";
            phone = "";
            portable = "";
            car = "";
            default = ''["", "", ""] // 醙'';
          };
          on-click = "${pkgs.pavucontrol}/bin/pavucontrol";
        };

        network = {
          interface = "wlp4s0";
          format = "{ifname}";
          format-wifi = " {bandwidthUpBytes}  {bandwidthDownBytes}";
          format-ethernet = "嬨 {ifname}/{cidr}";
          format-alt = "{essid}";
          format-disconnected = "";
          tooltip-format = "嬨 {ifname} via {gwaddr}";
          tooltip-format-wifi = "  {essid} ({signalStrength}%)";
          tooltip-format-ethernet = " {ifname}";
          tooltip-format-disconnected = "Disconnected";
          max-length = 50;
        };
      }
    ];
  };
}
