class HomeController < ApplicationController
  def index
    time = Time.now.strftime("%H:%M")

    @morning = time >= "00" && time < "12"
    @morning_say = "buenos dÃ­as ð"

    @afternoon = time >= "12" && time <= "19"
    @afternoon_say = "buenas tardes ð"

    @nigth = time > "19"
    @nigth_say = "buenas noches ð"
  end
end
