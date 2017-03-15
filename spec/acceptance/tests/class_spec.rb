require 'spec_helper_acceptance'
require 'helpers/acceptance/tests/class_shared_examples.rb'

describe 'kibana class v5' do
  let(:plugin)         { 'health_metric_vis' }
  let(:plugin_version) { '0.3.4' }
  let(:port)           { 5602 }
  let(:repo_version)   { '5.x' }
  let(:version)        { '5.2.0' }

  let(:manifest) do
    <<-EOS
        class { 'kibana':
          ensure => '#{version}',
          config => {
            'server.host' => '0.0.0.0',
            'server.port' => #{port},
          },
          repo_version => '#{repo_version}',
        } ->
        kibana_plugin { '#{plugin}':
          ensure  => 'present',
          url     => '#{plugin_url}',
          version => '#{plugin_version}',
        }
      EOS
  end

  let(:plugin_url) do
    "https://github.com/DeanF/#{plugin}/releases/download/v#{plugin_version}/#{plugin}-#{version}.zip"
  end

  include_examples 'class manifests',
                   '5',
                   '/usr/share/kibana/plugins/health_metric_vis/package.json',
                   '0.3.5'
end
