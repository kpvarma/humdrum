module ParamsParserHelper

  def parse_pagination_params
    @current_page = params[:page] || "1"
    @per_page = params[:per_page] || ConfigCenter::Defaults::ITEMS_PER_LIST.to_s

    if @per_page && @per_page.to_i > ConfigCenter::Defaults::MAX_ITEMS_PER_LIST
      @per_page = ConfigCenter::Defaults::ITEMS_PER_LIST.to_s
    end

    @offset = (@current_page.to_i - 1) * (@per_page.to_i)
  end

end


