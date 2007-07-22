ActionController::Base.send(:include, Rubaidh::ResourceSearch::Controller::InstanceMethods)
ActiveRecord::Base.send(    :extend, Rubaidh::ResourceSearch::Model::ClassMethods)