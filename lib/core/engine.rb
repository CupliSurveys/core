module Core
  class Engine < ::Rails::Engine
    isolate_namespace Core

    initializer :init_defaults do
      config.use_migrations = false unless config.try(:use_migrations)
    end

    initializer :append_migrations do |app|
      unless app.root.to_s.match(root.to_s)
        if config.use_migrations
          config.paths['db/migrate'].expanded.each do |expanded_path|
            app.config.paths['db/migrate'] << expanded_path
          end
        end
      end
    end
  end

  def self.setup(&block)
    yield config if block
    config
  end

  def self.config
    Engine.config
  end
end
