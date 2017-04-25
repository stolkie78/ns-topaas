require 'spec_helper'
describe 'topaas' do
  context 'with default values for all parameters' do
    it { should contain_class('topaas') }
  end
end
