require 'spec_helper'

describe package('python') do
  describe command('python2 --version') do
    its(:stderr) { should contain 'Python 2' }
  end

  describe command('python3 --version') do
    its(:stdout) { should contain 'Python 3' }
  end
end
