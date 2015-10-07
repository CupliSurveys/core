module Core
  # Квоты представляют собой объекты кампании, отображающие своими
  # характеристиками количество и параметры таргета посетителей.
  #
  # Связи между квотами можно отобразить в виде полносвязного графа (чем они,
  # собственно, и являются), где у каждой вершины может быть неограниченное
  # число как детей, так и родителей.
  #
  # ## Пример для наглядности
  #
  # Предположим, что у нас есть типовой запрос на исследование:
  #
  # ```text
  #          | 12-30 лет | 31-40 лет |
  #          |  м  |  ж  |  м  |  ж  |
  # Регион 1 | 120 | 130 |  60 |  65 |
  # Регион 2 |  90 | 100 | 140 | 150 |
  # ```
  #
  # Эту таблицу можно разложить следующим образом:
  #
  # - Регион 1
  #     - 21-30 лет
  #         - М (target: 120)
  #         - Ж (target: 130)
  #     - 31-40 лет
  #         - М (target: 60)
  #         - Ж (target: 65)
  # - Регион 2
  #     - 21-30 лет
  #         - М (target: 90)
  #         - Ж (target: 100)
  #     - 31-40 лет
  #         - М (target: 140)
  #         - Ж (target: 150)
  #
  # После этого остается лишь создать у необходимой кампании объекты Quotum по
  # такой же структуре. Для этого примера должно получиться 14 объектов Quotum.
  #
  class Quotum < ActiveRecord::Base
    belongs_to :campaign, touch: true
    belongs_to :question

    delegate :key,
      to: :question,
      prefix: true

    validates :campaign,
      presence: true

    scope :roots, -> { where(parent_ids: '{}') }
    scope :with_setting,
      -> (key, value) { where('settings ->> ? = ?', key, value) }

    after_create :assign_question_to_campaign

    # Assigns missing questions to campaign for link_builder
    def assign_question_to_campaign
      return if campaign.questions.include?(question)
      campaign.substitution_questions << question
    end

    # Fetches children quotum objects.
    #
    # @return [ActiveRecord::Relation] collection of Quota objects
    def children
      self.class.where('? = ANY(parent_ids)', id.to_s)
    end

    # Fetches parent quotum objects.
    #
    # @return [ActiveRecord::Relation] collection of Quota objects
    def parents
      self.class.where(id: parent_ids)
    end
  end
end
