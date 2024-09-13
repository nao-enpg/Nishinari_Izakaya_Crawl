class StaticPagesController < ApplicationController
  skip_before_action :require_login, only: [:top, :contact, :terms, :privacy_policy]

  def top; end

  def contact; end

  def terms; end

  def privacy_policy; end
end
