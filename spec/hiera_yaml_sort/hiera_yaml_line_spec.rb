# frozen_string_literal: true

RSpec.describe HieraYamlSort::HieraYamlLine do
  subject { described_class.new(content, children) }

  let(:content) { nil }
  let(:children) { [] }

  describe '#to_s' do
    let(:content) { "data\n" }

    context 'without children' do
      context 'when root is true' do
        it 'should return an empty string' do
          expect(subject.to_s(true)).to eq('')
        end
      end
      context 'when root is false' do
        it 'should return the data' do
          expect(subject.to_s(false)).to eq(content)
        end
      end
    end

    context 'with children' do
      let(:content) { "root:\n" }
      let(:children) { [child1, child2, child3] }
      let(:child1) { described_class.new("  foo: \"foo\"\n") }
      let(:child2) { described_class.new("  bar: \"bar\"\n") }
      let(:child3) { described_class.new("  baz: \"baz\"\n") }

      it 'should sort children' do
        expect(subject.to_s(false)).to eq <<~YAML
          root:
            bar: "bar"
            baz: "baz"
            foo: "foo"
        YAML
      end
    end
  end
end
