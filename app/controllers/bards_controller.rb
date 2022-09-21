class BardsController < ApplicationController
    def index
        render json: Bard.all
    end

    def show
        level = Bard.find_by(level: params[:id])
        if level
            render json: level
        else
            response = RestClient.get(api_url(bard_url))
            data = JSON.parse(response)
            new_level = Bard.create(
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

    def bard_url 
        return "/api/classes/bard/levels/#{params[:id]}"
    end
end
