class SubscriptionCucumberator < ActiveCucumber::Cucumberator

  def value_for_show
    show.try :name
  end

end
