module Core::Concerns
  module CampaignStateMachine
    extend ActiveSupport::Concern

    included do
      state_machine :state, initial: :new do
        event :submit do
          transition new: :on_moderation
        end

        event :activate do
          transition on_moderation: :active, paused: :active,
                     previewing: :active
        end

        event :pause do
          transition active: :paused, on_moderation: :paused
        end

        event :finish do
          transition active: :finished, paused: :finished, previewing: :finished
        end

        event :reject do
          transition on_moderation: :new
        end

        event :preview do
          transition on_moderation: :previewing
        end
      end
    end
  end
end
