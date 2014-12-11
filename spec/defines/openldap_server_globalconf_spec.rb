require 'spec_helper'

describe 'openldap::server::globalconf' do

  let(:title) { 'foo' }

  on_pe_supported_platforms.each do |version, platforms|
    platforms.each do |platform, facts|
      context "on #{version} #{platform}" do
        let(:facts) do
          facts
        end

        context 'without value' do
          it { expect { is_expected.to compile }.to raise_error(/Must pass value to Openldap::Server::Globalconf\[foo\]/) }
        end

        context 'with a value' do
          let(:params) {{ :value => 'bar' }}

          context 'with olc provider' do
            context 'with no parameters' do
              let :pre_condition do
                "class { 'openldap::server': }"
              end

              it { is_expected.to compile.with_all_deps }
              it { is_expected.to contain_openldap__server__globalconf('foo').with({
                :value => 'bar',
              })}

            end
          end
        end
      end
    end
  end
end
