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
          observer = options.delete(:observer)
          class_and_id = "search_#{name}"
          path = send("#{name.to_s.pluralize}_path")

          remote_form_for(name,{
            :url => path,
            :method => :get,
            :html => {
              :class => class_and_id,
              :id => class_and_id,
            }.merge(options[:html] || {})
          }.merge(options), &block)

          unless observer.nil?
            concat observe_field("#{name}_#{observer}",
              :frequency => 0.5,
              :url => path,
              :with => "Form.serialize('#{class_and_id}')",
              :method => :get), block.binding
          end
        end
      end
    end
  end
end