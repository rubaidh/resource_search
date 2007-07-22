module Rubaidh
  module ResourceSearch
    module Controller
      module InstanceMethods
        def self.included(base)
          base.around_filter :process_search_terms, :only => [:index]
        end

        def process_search_terms
          self.class.to_s.gsub(/Controller/, '').singularize.constantize.with_search_terms(params) do
            yield
          end
        end
      end
    end
  end
end