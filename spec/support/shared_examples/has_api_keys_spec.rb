require 'spec_helper'

shared_examples_for 'has api keys' do
  let(:model) { described_class }
  let(:inst) { create(model.to_s.split('::').last.underscore.to_sym) }
  let(:keys_count) { 3 }

  before do
    keys_count.times { inst.api_keys.create }
  end

  it { expect(inst).to have_many(:api_keys) }
  it { expect(inst.api_keys.count).to eq(keys_count) }
end
