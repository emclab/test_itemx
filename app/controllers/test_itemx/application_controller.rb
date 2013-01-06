module TestItemx
  class ApplicationController < ActionController::Base
    helper Authentify::SessionsHelper
    helper Authentify::UserPrivilegeHelper
    helper Authentify::AuthentifyUtility
    helper TestItemx::SessionsHelper
    include Authentify::SessionsHelper
    include Authentify::UserPrivilegeHelper
    include Authentify::AuthentifyUtility
    include TestItemx::SessionsHelper
  end
end
