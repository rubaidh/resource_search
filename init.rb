require 'rubaidh/core_ext/enumerable'

ActionController::Base.send(:include, Rubaidh::ResourceSearch::Controller)
ActiveRecord::Base.send(    :extend,  Rubaidh::ResourceSearch::Model::ClassMethods)
ActionView::Base.send(      :include, Rubaidh::ResourceSearch::FormHelper)