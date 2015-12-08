require 'spec_helper'

shared_examples_for 'nameable' do
  let(:model) { described_class }

  let(:email) { 'qwe@qwe.qwe' }
  let(:inst) { create(model.to_s.split('::').last.underscore.to_sym, params) }
  let(:first_name) { '123' }
  let(:last_name) { '567' }
  let(:full_name) { "#{ first_name } #{ last_name }" }

  let(:params) do
    {
      first_name: first_name,
      last_name: last_name,
      email: email
    }
  end

  describe 'instance methods' do
    describe '#full_name' do
      it { expect(inst.full_name).to eq(full_name) }

      context 'when first_name blank' do
        let(:first_name) { '' }

        it { expect(inst.full_name).to eq(last_name) }
      end

      context 'when last_name blank' do
        let(:last_name) { '' }

        it { expect(inst.full_name).to eq(first_name) }
      end
    end

    describe '#full_name=' do
      let(:set_name) { "#{ first_name } Middlename #{ last_name }" }

      before { inst.full_name = set_name }

      it { expect(inst.full_name).to eq(full_name) }
    end

    describe '#name' do
      it { expect(inst.name).to eq(full_name) }

      context 'when first_name and last_name is blank' do
        before { inst.update(first_name: '', last_name: '') }

        it { expect(inst.name).to eq(email) }
      end
    end
  end

  describe 'normalize data' do
    context 'when names contains trailing whitespaces' do
      let(:first_name) { ' 123 ' }
      let(:last_name) { ' 444 567       ' }

      it { expect(inst.first_name).to eq(first_name.strip) }
      it { expect(inst.last_name).to eq(last_name.strip) }
    end
  end
end
