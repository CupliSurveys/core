require 'spec_helper'

shared_examples_for 'roleable' do
  let(:model) { described_class }

  it { expect(model::ROLES).to be_a(Array) }
  it { expect(model::ROLES).not_to be_blank }

  describe 'instance methods' do
    let(:inst) { create(model.to_s.split('::').last.underscore.to_sym) }
    let(:roles) { [model::ROLES.first] }

    describe '#roles=' do
      it { expect { inst.roles = roles }.to change { inst.roles_mask } }
      it { expect { inst.roles = [] }.not_to change { inst.roles_mask } }
    end

    describe '#roles' do
      before { inst.roles = roles }

      it { expect(inst.roles).to match_array(roles) }
    end

    describe '#is?' do
      before { inst.roles = roles }

      it { expect(inst.is?(roles.first)).to be_truthy }
    end

    describe '#available_roles' do
      it { expect(inst.available_roles).to eq(model::ROLES) }
    end
  end
end
