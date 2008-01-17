# Pull a spec_helper from the hosting Rails application.
# FIXME: At some point it would be nice not to need the plugin to be
# part of a Rails application in order to test it...
require "#{File.dirname(__FILE__)}/../../../../spec/spec_helper"
