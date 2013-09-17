require 'spec_helper'
require 'factories/api/error_presenter_factory'

describe API::ErrorPresenterFactory do
  describe '.build' do
    let(:an_exception) do
      exception = Class.new(Exception)
      exception.stub(:class).and_return('MyException')

      exception
    end

    before(:each) do
      stub_const('Container', double)
      Container.stub(:get)
    end

    context 'when a presenter is defined for the exception' do
      let(:presenter) do
        presenter = double
        presenter.stub(:exception=)

        presenter
      end

      before(:each) do
        Container.stub(:get).with('error.my_exception').and_return(presenter)
      end

      it 'returns a presenter instance' do
        API::ErrorPresenterFactory.build(an_exception).should == presenter
      end

      it 'sets the exception in the presenter instance' do
        presenter.should_receive(:exception=).with(an_exception)
        API::ErrorPresenterFactory.build(an_exception)
      end
    end

    context 'when no presenter are  defined for the exception' do
      before(:each) do
        Container.stub(:get).with('error.my_exception').and_return(nil)
      end

      it 'raises again the exception' do
        expect { API::ErrorPresenterFactory.build(an_exception) }.to raise_error(an_exception)
      end
    end
  end
end
