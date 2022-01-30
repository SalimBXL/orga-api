class PostitsController < ApplicationController
    before_action :authenticate_user, only: [:create, :update, :destroy]
    before_action :find_postit, only: [:show, :update, :destroy]
    before_action :check_authorization, only: [:update, :destroy]

    def index
        render json: { error: "missing parameters" }, status: :bad_request and return unless (params[:page] && params[:per_page])
        paginate json: Postit.all, status: :partial_content
    end

    def show
        render json: @postit
    end

    def create
        postit = current_user.postits.create(postit_params)
        render json: postit, status: :created and return if postit.save
        render json: postit.errors.details, status: :bad_request
    end

    def update
        render json: @postit and return if @postit.update(postit_params)
        render json: @postit.errors.details, status: :bad_request
    end

    def destroy
        render json: {}, status: :no_content and return if @postit.destroy
        render json: @postit.errors.details, status: :bad_request
    end

    private

    def postit_params
        params.required(:postit).permit(:title, :body, :level)
    end

    def find_postit
        @postit = Postit.find_by(id: params[:id])
        render json: {}, status: :not_found and return unless @postit
    end

    def check_authorization
        render json: {}, status: :forbidden and return unless @postit.user_id == current_user.id
    end

end
