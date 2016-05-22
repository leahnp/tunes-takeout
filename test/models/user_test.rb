require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    # @known = OmniAuth.config.mock_auth[:spotify_known]
    @known = { "provider" => 'spotify', "info" => { "id" => "known_user", "display_name" => "known user" } }
    @unknown = OmniAuth.config.mock_auth[:spotify_unknown]
    @unknown_with_uid = OmniAuth.config.mock_auth[:spotify_uid]
  end
end
