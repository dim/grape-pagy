ENV['RACK_ENV'] ||= 'test'

require 'rspec'
require 'grape/pagy'
require 'rack/test'

Pagy::DEFAULT[:limit] = 10
Pagy::DEFAULT[:limit_max] = 20

class TestArray < Array
  def limit(num)
    self.class.new slice(0, num)
  end

  def offset(num)
    self.class.new slice(num..-1)
  end
end

class TestAPI < Grape::API
  helpers Grape::Pagy::Helpers

  params do
    use :pagy, limit: 5, limit_max: 6
  end
  get '' do
    pagy (1..12).to_a
  end

  params do
    use :pagy
  end
  get '/no-opts' do
    pagy (1..12).to_a
  end

  params do
    use :pagy, limit: 3
  end
  get '/countless' do
    pagy TestArray.new((1..12).to_a), using: :countless
  end

  resource :sub do
    params do
      use :pagy, limit_param: :per_page
    end
    get '/' do
      pagy (1..12).to_a, count: 13
    end
  end
end

RSpec.configure do |config|
  config.include Rack::Test::Methods
  config.raise_errors_for_deprecations!
end
