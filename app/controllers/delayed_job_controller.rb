class DelayedJobController < ApplicationController
  def index
    @jobs = Delayed::Job
  end

end
