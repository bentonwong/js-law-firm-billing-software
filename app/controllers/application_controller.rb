class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  include ApplicationHelper
  include MatterHelper
  include TimeEntryHelper

end
