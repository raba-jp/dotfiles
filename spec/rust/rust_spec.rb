# frozen_string_literal: true

require 'spec_helper'

describe file("#{ENV['HOME']}/.local/share/cargo/bin/rustup") do
  it { should be_file }
  it { should be_executable }
end

describe file("#{ENV['HOME']}/.local/share/cargo/bin/cargo") do
  it { should be_file }
  it { should be_executable }
end
