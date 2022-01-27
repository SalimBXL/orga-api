class PostitsController < ApplicationController

    def show
        render json: Postit.find(params[:id])
    end
end
