require 'spec_helper'

describe command('rustup --version') do
  its(:exit_status) { should eq 0 }
end