class PostitsController < ApplicationController

    def index
        render json: Postit.all
    end

    def show
        render json: Postit.find(params[:id])
    end
end
