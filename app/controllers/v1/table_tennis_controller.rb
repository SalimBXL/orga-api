class V1::TableTennisController < ApplicationController
    #before_action :authenticate_user

    def ping
        if current_user
            render json: { response: 'authorized pong' }
        else
            render json: { response: 'unauthorized pong' }
        end
    end
    
end
