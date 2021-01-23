lsp_root = File.expand_path("~/.local/share/lua-language-server")

git "lua-language-server" do
  repository "https://github.com/sumneko/lua-language-server"
  destination lsp_root
  recursive true
end

if manjaro_linux?
  execute "ninja -f ninja/linux.ninja" do
    cwd File.join(lsp_root, "3rd", "luamake")
  end
end

if darwin?
  execute "ninja -f ninja/macos.ninja" do
    cwd File.join(lsp_root, "3rd", "luamake")
  end
end

execute "./3rd/luamake/luamake rebuild" do
  cwd lsp_root
end
