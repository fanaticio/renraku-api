require 'spec_helper'
require 'presenters/api/template_presenter'

describe API::TemplatePresenter do
  subject { API::TemplatePresenter.new(double) }

  expect_it { to have_attr_accessor :template }
  expect_it { to delegates(:name).to(:template) }
end
