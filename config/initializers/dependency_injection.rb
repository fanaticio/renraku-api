require 'dependency_injection/container'
require 'dependency_injection/loaders/yaml'

Container = DependencyInjection::Container.new
loader    = DependencyInjection::Loaders::Yaml.new(Container)
loader.load(Rails.root.join('config', 'dependency_injection.yml'))
