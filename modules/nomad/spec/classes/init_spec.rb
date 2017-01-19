require 'spec_helper'
describe 'nomad' do
  context 'with default values for all parameters' do
    it { should contain_class('nomad') }
  end
end
