module Rubaidh
  module ResourceSearch
    module FormHelper
      def self.included(base)
        base.send(:include, InstanceMethods)
      end

      module InstanceMethods
        def search_form_for(name, options = {}, &block)
          form_for(name, {
            :url => send("#{name.to_s.pluralize}_path"),
            :html => {
              :class => "search_#{name}",
              :id => "search_#{name}",
              :method => :get
            }.merge(options[:html] || {})
          }.merge(options), &block)
        end
        
        def remote_search_form_for(name, options = {}, &block)
          remote_form_for(name,{
            :url => send("#{name.to_s.pluralize}_path"),
            :method => :get,
            :html => {
              :class => "search_#{name}",
              :id => "search_#{name}",
            }.merge(options[:html] || {})
          }.merge(options), &block)
        end
      end
    end
  end
end