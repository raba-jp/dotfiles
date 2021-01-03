darwin_pkg "git"
manjaro_pkg "git"

link File.expand_path("~/.config/git/ignore") do
  force true
  to File.expand_path("cookbooks/git/files/ignore")
end
link File.expand_path("~/.config/git/config") do
  force true
  to File.expand_path("cookbooks/git/files/config")
end

darwin_pkg "tig"
manjaro_pkg "tig"

link File.expand_path("~/.config/tig/config") do
  force true
  to File.expand_path("cookbooks/git/files/tig_config")
end
