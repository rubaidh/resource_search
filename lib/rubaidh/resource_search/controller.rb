module Rubaidh
  module ResourceSearch
    module Controller
      def self.included(base)
        base.extend(ActsMethods)
      end

      module ActsMethods
        def resource_search(options = { :only => [:index] })
          include InstanceMethods unless included_modules.include?(InstanceMethods)
          around_filter :process_search_terms, options
        end
      end

      module InstanceMethods
        def process_search_terms
          model = self.class.to_s.gsub(/Controller/, '').singularize
          model.constantize.with_search_terms(params[model.downcase]) do
            yield
          end
        end
      end
    end
  end
end