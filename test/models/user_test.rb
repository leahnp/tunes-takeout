require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @known = {
      "provider" => "spotify", 
      "uid" => "1"
    }

    @unknown = {
      "provider" => "spotify",
      "uid" => "2",
      "info" => {
        "name" => "bob",
        "image" => "bob.jpg",
        "urls" => { "spotify" => "bob.spotify.com" },
        "email" => "bob@builder.com"
      }
    }
  end

  test "can find an existing user given an oauth spotify hash" do
    assert_equal users(:known_user), User.find_or_create_from_omniauth(@known)
  end

  test "uses oauth data to set user name, provider and uid for new users" do
    user = User.find_or_create_from_omniauth(@unknown)

    assert_equal @unknown["provider"], user.provider
    assert_equal @unknown["uid"], user.uid
    assert_equal @unknown["info"]["name"], user.name
    assert_equal @unknown["info"]["image"], user.photo
    assert_equal @unknown["info"]["urls"]["spotify"], user.profile_link
    assert_equal @unknown["info"]["email"], user.email
  end
end
