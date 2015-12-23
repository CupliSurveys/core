module FactoryGirl
  module Syntax
    module Methods
      def find_or_create(name, attributes = {}, &block)
        result =
          FactoryGirl.
            factory_by_name(name).
            build_class.
            find_by(attributes, &block)

        result || FactoryGirl.create(name, attributes, &block)
      end
    end
  end
end
