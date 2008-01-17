module Rubaidh
  module ResourceSearch
    module Controller
      def self.included(base)
        base.extend(ActsMethods)
      end

      module ActsMethods
        def resource_search(options = { :only => [:index] })
          extend ClassMethods 
          include InstanceMethods unless included_modules.include?(InstanceMethods)

          around_filter :process_search_terms, options
        end
      end

      module ClassMethods
        # FIXME: I'm not sure if this is the canonically correct way to get
        # the name of the model based upon the controller's name.
        def resource_model
          "::#{name.demodulize.sub(/Controller$/,'')}".classify.constantize
        end
      end

      module InstanceMethods
        def process_search_terms(&block)
          resource_model.with_search_terms(params[resource_model.to_s.underscore], &block)
        end
        
        private
        def resource_model
          self.class.resource_model
        end
      end
    end
  end
end