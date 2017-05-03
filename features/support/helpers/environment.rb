require "base64"

module Auth_app

def Auth_app.get_hash(user, password)
  Base64.encode64("#{user}:#{password}")
end

def Auth_app.make_base_auth
    return "Basic " + get_hash($app_user, $app_password);
end

end
