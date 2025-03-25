# frozen_string_literal: true

class SubscriptionCucumberator < ActiveCucumber::Cucumberator
  def value_for_show
    show.try :name
  end

  def value_for_subscriber
    subscriber == @current_user ? "me" : subscriber
  end
end
