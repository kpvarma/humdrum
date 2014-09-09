class ApplicationController < ActionController::Base
  protect_from_forgery

  include DisplayHelper
  include FlashHelper
  include ImageHelper
  include MetaTagsHelper
  include NavigationHelper
  include ParamsParserHelper
  include TitleHelper

end
