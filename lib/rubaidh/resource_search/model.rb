module Rubaidh
  module ResourceSearch
    module Model
      module ClassMethods
        def with_search_terms(params, &block)
          with_scope( { :find => resource_search_scope(params) }, &block)
        end
        
        private
        def resource_search_scope(params)
          conditions = params.blank? ? [] : params.delete_if do |key, value|
           !column_names.include?(key)
          end.collect do |key, value|
           ["LOWER(#{table_name}.#{key}) LIKE ?", "%#{value.downcase}%"]
          end.unzip

          conditions.length > 1 && conditions[0] = conditions[0].join(' AND ')

          { :conditions => conditions.flatten }
        end
      end
    end
  end
end