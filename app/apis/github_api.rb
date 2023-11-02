class GithubApi
  API_URL = "https://api.github.com/search/repositories".freeze
  SORT_KEYWORDS = ["stars", "forks", "help-wanted-issues", "updated"].freeze
  ORDER_KEYWORDS = ["desc", "asc"].freeze

  def initialize(query, sort: nil, order: nil)
    raise ArgumentError, "query must be present" unless query.present?
    @query = query
    raise ArgumentError, "sort must be one of: #{SORT_KEYWORDS.join(", ")}" unless sort.nil? || SORT_KEYWORDS.include?(sort)
    @sort = sort
    raise ArgumentError, "order must be one of: #{ORDER_KEYWORDS.join(", ")}" unless order.nil? || ORDER_KEYWORDS.include?(order)
    @order = order.present? && ORDER_KEYWORDS.include?(order) ? order : nil
  end

  def self.call(query, sort: nil, order: nil)
    new(query, sort: sort, order: order).call
  end

  def call
    uri = URI(API_URL)
    uri.query = URI.encode_www_form({ q: @query, sort: @sort, order: @order }.compact)
    JSON.parse(Net::HTTP.get(uri), symbolize_names: true)
  end
end
