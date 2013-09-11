require 'spec_helper'
require 'errors/api/validation_error.rb'

describe API::ValidationError do
  subject { API::ValidationError.new({}) }

  it { should have_attr_accessor :fields }
end
