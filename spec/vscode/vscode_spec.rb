# frozen_string_literal: true

require 'spec_helper'

describe command('code -v') do
  its(:exit_status) { should eq 0 }

  context 'darwin', if: os[:family] == 'darwin' do
    [
      "#{ENV['HOME']}/Library/Application\ Support/Code/User/settings.json",
      "#{ENV['HOME']}/Library/Application\ Support/Code/User/keybindings.json",
      "#{ENV['HOME']}/Library/Application\ Support/Code/User/locale.json",
      "#{ENV['HOME']}/Library/Application\ Support/Code/User/projects.json"
    ].each do |f|
      describe file(f) do
        it { should be_file }
        it { should be_owned_by ENV['USER'] }
      end
    end
  end

  context 'ubuntu', if: os[:family] == 'ubuntu' do
    [
      "#{ENV['HOME']}/.config/Code/User/settings.json",
      "#{ENV['HOME']}/.config/Code/User/keybindings.json",
      "#{ENV['HOME']}/.config/Code/User/locale.json",
      "#{ENV['HOME']}/.config/Code/User/projects.json"
    ].each do |f|
      describe file(f) do
        it { should be_file }
        it { should be_owned_by ENV['USER'] }
      end
    end
  end

  describe 'extensions' do
    %w[
      2gua.rainbow-brackets
      alefragnani.project-manager
      apollographql.vscode-apollo
      auchenberg.vscode-browser-preview
      BazelBuild.vscode-bazel
      bungcip.better-toml
      castwide.solargraph
      dbaeumer.vscode-eslint
      eamodio.gitlens
      esbenp.prettier-vscode
      formulahendry.vscode-mysql
      gerane.Theme-Solarized-dark
      GitHub.vscode-pull-request-github
      googlecloudtools.cloudcode
      jebbs.plantuml
      jnbt.vscode-rufo
      keyring.Lua
      mauve.terraform
      misogi.ruby-rubocop
      ms-azuretools.vscode-docker
      MS-CEINTL.vscode-language-pack-ja
      ms-kubernetes-tools.vscode-kubernetes-tools
      ms-python.python
      ms-vscode.Go
      ms-vsliveshare.vsliveshare
      octref.vetur
      PKief.material-icon-theme
      rebornix.ruby
      redhat.vscode-yaml
      samuelcolvin.jinjahtml
      silvenon.mdx
      VisualStudioExptTeam.vscodeintellicode
      vscodevim.vim
      wholroyd.jinja
      zxh404.vscode-proto3
    ].each do |ext|
      describe command("code --list-extensions | grep '#{ext}'") do
        its(:exit_status) { should eq 0 }
      end
    end
  end
end
