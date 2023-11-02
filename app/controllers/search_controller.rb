class SearchesController < ApplicationController
  def show
    render json: GithubApi.call(search_params[:query], sort: search_params[:sort], order: search_params[:order])
  rescue ArgumentError => e
    render json: { error: e.message }, status: :bad_request
  end

  private

  def search_params
    params.permit(:query, :sort, :order)
  end
end
