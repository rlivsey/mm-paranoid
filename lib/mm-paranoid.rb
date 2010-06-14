require 'mongo_mapper'

module MongoMapper
  module Plugins
    module Paranoid
      def self.included(model)
        model.plugin self
      end

      def self.configure(base)
        base.key(:deleted_at, Time, :index => true)
      end

      module InstanceMethods
        def destroy
          run_callbacks(:before_destroy)
          self.deleted_at = Time.now
          result = self.save
          run_callbacks(:after_destroy)
          result
        end

        def deleted?
          !self.deleted_at.nil?
        end

        def destroyed?
          deleted?
        end
      end
    end
  end
end