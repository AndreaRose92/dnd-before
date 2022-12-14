class ApplicationController < ActionController::API
  include ActionController::Cookies
  require "rest-client"

  before_action :authorize
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :render_invalid

  def api_url
    return "http://www.dnd5eapi.co/api"
  end

  def current_user
    User.find_by(id: session[:user_id])
  end

  def render_not_found(invalid)
    render json: { error: invalid.message }, status: :not_found
  end

  def render_invalid(invalid)
    render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
  end

  def authorize
    return render json: { error: "Not Authorized" }, status: :unauthorized unless current_user
  end

  def stringify_fetch(array)
    array.pluck("name").join(", ")
  end

  def parse_stat(string)
    case string
    when "STR"
      "strength"
    when "DEX"
      "dexterity"
    when "CON"
      "constitution"
    when "INT"
      "intelligence"
    when "WIS"
      "wisdom"
    when "CHA"
      "charisma"
    end
  end

  def find_abi(array)
    stat_bonuses = {
      strength: 0,
      dexterity: 0,
      constitution: 0,
      intelligence: 0,
      wisdom: 0,
      charisma: 0,
    }
    array.each { |stat|
      stat_bonuses[parse_stat(stat["ability_score"]["name"])] = stat["bonus"]
    }
    stat_bonuses
  end

  def damage_data(string)
    if string.include?("+")
      dice = string.split("+")[0]
      modifier = string.split("+")[1]
    else
      modifier = 0
      dice = string
    end
  
    dSize = dice.split("d")[1]
    dAmt = dice.split("d")[0]
  
    return [dAmt, dSize, modifier]
  end
end
