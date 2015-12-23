module Core
  class BaseModel < ActiveRecord::Base
    self.abstract_class = true

    if Engine.config.try(:database_config)
      establish_connection(Engine.config.database_config.to_sym)
    end
  end
end
