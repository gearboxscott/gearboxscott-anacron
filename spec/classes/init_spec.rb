require 'spec_helper'
describe 'cron' do

  context 'with defaults for all parameters' do
    it { should contain_class('cron') }
  end
end
