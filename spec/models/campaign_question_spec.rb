require 'spec_helper'

describe Core::CampaignQuestion do
  let!(:collector) { create(:question, :collector) }
  it do
    is_expected.
      to allow_value(question_type: 'number_input', shuffled_answers: false).
      for(:settings)
  end

  describe 'instance methods' do
    describe '#substitution' do
      let!(:substitution) do
        params = {
          campaign_id: campaign_question.campaign_id,
          question_id: campaign_question.question_id
        }
        create(:substitution, params)
      end

      let(:campaign_question) { create(:campaign_question) }

      it { expect(campaign_question.substitution).to eq(substitution) }
    end

    describe 'ActiveRecord overriden' do
      let!(:campaign) { create(:simple_campaign) }
      let(:question) { create(:question) }

      let(:base_params) do
        { campaign_id: campaign.id, question_id: question.id }
      end

      describe '#new+save' do
        let(:params) { base_params }

        subject do
          camp_question = Core::CampaignQuestion.new(params)
          camp_question.save
          camp_question
        end

        it { is_expected.to eq(Core::CampaignQuestion.last) }

        context 'with answers', mock: :elastic do
          let(:ans_params) do
            { answers: [{ text: 'qwe' }, { text: '123' }] }
          end

          let(:params) { base_params.merge(ans_params) }

          it { is_expected.to eq(Core::CampaignQuestion.last) }
          it { expect(subject.answers.count).to eq(2) }
        end
      end

      describe '#create' do
        subject { Core::CampaignQuestion.create(base_params) }

        it 'creates new CampaignQuestion' do
          expect { subject }.to change { Core::CampaignQuestion.count }.by(1)
        end
      end

      describe '#update' do
        let(:campaign_question) { create(:campaign_question) }
        let(:settings) { { 'qwe' => 123 } }
        let(:params) { { settings: settings } }

        subject do
          campaign_question.update(params)
          campaign_question
        end

        it { expect(subject.settings).to eq(settings) }
        it { expect(subject.answers.count).to eq(0) }

        context 'with answers', mock: :elastic do
          let(:params) { { settings: settings, answers: [{ text: '1' }] } }

          it { expect(subject.settings).to eq(settings) }
          it { expect(subject.answers.count).to eq(1) }
        end

        context 'with answers (no elastic mocks)' do
          let(:params) { { settings: settings, answers: answers } }

          context 'CompoundRegion' do
            let(:compound_region) { create(:compound_region) }

            let(:answers) do
              [{ id: compound_region.id, type: 'compound_region' }]
            end

            it { expect(subject.compound_regions.count).to eq(1) }
          end

          context 'City' do
            let(:compound_region) { create(:compound_region) }

            let(:answers) do
              [{ id: compound_region.id, type: 'compound_region' }]
            end

            it { expect(subject.compound_regions.count).to eq(1) }
          end

          context 'Answer' do
            let(:answer) { create(:answer) }

            let(:answers) do
              [{ id: answer.id, type: 'answer', text: 'text' }]
            end

            it { expect(subject.answers.count).to eq(1) }
          end
        end
      end
    end
  end
end
