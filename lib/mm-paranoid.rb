require 'mongo_mapper'

module MongoMapper
  module Plugins
    module Paranoid
      extend ActiveSupport::Concern

      included do
        key :deleted_at, Time, :index => true
      end

      module InstanceMethods
        def destroy
          run_callbacks(:destroy) do
            self.deleted_at = Time.now
            self.save
          end
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