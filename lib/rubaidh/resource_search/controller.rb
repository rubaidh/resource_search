module Rubaidh
  module ResourceSearch
    module Controller
      module InstanceMethods
        def self.included(base)
          base.around_filter :process_search_terms, :only => [:index]
        end

        def process_search_terms
          model = self.class.to_s.gsub(/Controller/, '').singularize
          model.constantize.with_search_terms(params[model.downcase]) do
            yield
          end
        rescue NameError
          # FIXME: This can not be the fastest implementation -- to try and
          # get the resource class name and fail every time if it doesn't
          # exist.  Maybe we need to eschew some elegance and have an acts
          # method in each controller that's a resource-based controller.
          yield
        end
      end
    end
  end
end