# frozen_string_literal: true

require 'spec_helper'

describe package('clojure') do
  it { should be_installed }
end

describe file("#{ENV['HOME']}/.config/clojure/deps.edn") do
  it { should be_symlink }
  it { should be_readable }
  it { should be_owned_by ENV['USER'] }
end
