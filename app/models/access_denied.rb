# This error is raised when a user isn't allowed to access a given controller action.
class AccessDenied < StandardError
  attr_reader :action, :subject
  attr_writer :default_message

  def initialize(message = nil, action = nil, subject = nil)
    @message = message
    @action = action
    @subject = subject
    @default_message = I18n.t(:"unauthorized.default", :default => "You are not authorized to access this page.")
  end

  def to_s
    @message || @default_message
  end
end
