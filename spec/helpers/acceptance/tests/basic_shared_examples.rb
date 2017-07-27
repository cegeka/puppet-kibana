shared_examples 'basic acceptance' do
  context 'example manifest' do
    it { apply_manifest(manifest, :catch_failures => true) }
    it { apply_manifest(manifest, :catch_changes  => true) }

    describe package('kibana') do
      it { is_expected.to be_installed }
    end

    describe service('kibana') do
      it { is_expected.to be_enabled }
      it { is_expected.to be_running }
    end

    describe port(5602) { it { should be_listening } }

    describe server :container do
      describe http('http://localhost:5602') do
        it('returns OK', :api) { expect(response.status).to eq(200) }
        it('is live', :api) { expect(response['kbn-name']).to eq('kibana') }
        it 'installs the correct version', :api do
          expect(response['kbn-version']).to eq(version)
        end
      end
    end
  end
end
