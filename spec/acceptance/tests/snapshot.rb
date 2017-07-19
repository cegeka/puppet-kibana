require 'spec_helper_acceptance'
require 'helpers/acceptance/tests/basic_shared_examples'

describe 'kibana snapshots' do
  let(:port) { 5602 }
  let(:version) { RSpec.configuration.snapshot_version }
  let(:manifest) do
    <<~EOS
      class { 'kibana':
        config => {
          'server.host' => '0.0.0.0',
          'server.port' => #{port},
        },
        manage_repo => false,
        package_source => '/tmp/kibana-snapshot.#{RSpec.configuration.pkg_ext}',
      }
    EOS
  end

  include_examples 'basic acceptance'
end
