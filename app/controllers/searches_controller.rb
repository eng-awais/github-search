class SearchesController < ApplicationController
  def index
    render json: GithubApi.call(searches_params[:query], sort: searches_params[:sort], order: searches_params[:order])
  rescue ArgumentError => e
    render json: { error: e.message }, status: :bad_request
  end

  private

  def searches_params
    params.permit(:query, :sort, :order)
  end
end
