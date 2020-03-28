# alacritty用に /usr/local/bin 以下にシンボリックリンクを貼る
link "/usr/local/bin/fish" do
  user "root"
  to "/usr/bin/fish"
end
