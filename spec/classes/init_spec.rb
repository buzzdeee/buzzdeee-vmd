require 'spec_helper'
describe 'vmd' do
  context 'with default values for all parameters' do
    it { should contain_class('vmd') }
  end
end
