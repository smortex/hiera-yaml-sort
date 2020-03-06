# frozen_string_literal: true

RSpec.describe HieraYamlSort::HieraYamlFile do
  subject { described_class.new(filename) }

  context 'with a trivial YAML file' do
    let(:filename) { 'spec/fixtures/sample1.yaml' }

    it 'should sort entries' do
      expect(subject.to_s).to eq <<~YAML
        ---
        bar: "foo"
        foo: "bar"
      YAML
    end
  end

  context 'with a simple yaml file' do
    let(:filename) { 'spec/fixtures/sample2.yaml' }

    it 'should sort entries' do
      expect(subject.to_s).to eq <<~YAML
        ---
        bar: "bar"
        foo:
          bar: "bar"
          foo:
            bar: "bar"
            foo:
              bar: "bar"
      YAML
    end
  end
end
