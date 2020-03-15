[
  { key: "org.gnome.shell.app-switcher current-workspace-only", value: "false" },
  { key: "org.gnome.shell.extensions.user-theme name", value: "'Arc-Dark'" },
  {
    key: "org.gnome.shell.extensions.auto-move-windows application-list",
    value: "['google-chrome.desktop:1', 'visual-studio-code.desktop:2', 'alacritty.desktop:3', 'station.desktop:4']"
  }
].each do |s|
execute "gsettings set #{s[:key]} #{s[:value]}" do
  user node["user"]
end
