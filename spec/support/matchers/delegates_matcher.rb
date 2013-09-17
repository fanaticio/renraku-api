RSpec::Matchers.define :delegates do |method|
  match do |object|
    if object.respond_to?(method)
      delegate_object = double
      delegate_object.stub(method).and_return(:delegate_called)

      object.stub(@to).and_return(delegate_object)

      object.send(method) == :delegate_called
    else
      false
    end
  end

  description do
    "delegate #{method} to #{@to}"
  end

  failure_message_for_should do
    "expected #{object} to delegate :#{method} to #{@to}"
  end

  failure_message_for_should_not do
    "expected #{object} don't delegate #{method} to #{@to}"
  end

  chain(:to) { |receiver| @to = receiver }
end
