RSpec::Matchers.define :have_attr_accessor do |accessor_name|
  match do |object|
    object.respond_to?(accessor_name) && object.class.instance_method(accessor_name).arity == 0 \
      && object.respond_to?("#{accessor_name}=") && object.class.instance_method("#{accessor_name}=").arity == 1
  end

  failure_message_for_should do |object|
    "expected that #{object} have #{accessor_name} accessor"
  end

  failure_message_for_should_not do |object|
    "expected that #{object} have not #{accessor_name} accessor"
  end

  description do
    "have #{accessor_name} accessor"
  end
end
