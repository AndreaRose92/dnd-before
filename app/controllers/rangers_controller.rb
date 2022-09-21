class RangersController < ApplicationController
    def index
        render json: Ranger.all
    end

    def show
        level = Ranger.find_by(level: params[:id])
        if level
            render json: level
        else
            response = RestClient.get(api_url(ranger_url))
            data = JSON.parse(response)
            new_level = Ranger.create(
                level: data["level"],
                prof_bonus: data["prof_bonus"],
                features: data["features"].pluck("name").join(", "),
                class_specific: data["class_specific"].map {
                    |k,v| "#{k}: #{v}"
                }.join(', '),
                abi: data["ability_score_bonuses"],
            )
            render json: new_level
        end
    end

    private

    def ranger_url 
        return "/api/classes/ranger/levels/#{params[:id]}"
    end
end
