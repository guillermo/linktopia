
gem 'mechanize', '= 0.9.0'
require 'webrat'
require 'progressbar'

Webrat.configure do |config|
  config.mode = :mechanize
end

class Scrapper < Webrat::MechanizeAdapter
  include Webrat::Matchers
  include Webrat::Methods
  # no idea why we need this but without it response_code is not always recognized
  Webrat::Methods.delegate_to_session :response_code, :response_body
  
  def doc
    current_dom
  end
  
  def initialize(*args, &block)
    super_return = super
    yield self if block_given?
    super_return
  end
  
  delegate :at_css, :css, :to => :doc
end

