module TokenGenerator

  def self.token
    @@token ||= get_token
  end

  def self.get_token
    response = HTTParty.post("https://api.twitter.com/oauth2/token",
                             query: {"grant_type" => 'client_credentials'},
                             headers: {"Host" => "api.twitter.com",
                                       "Accept-Encoding" => "gzip",
                                       "User-Agent" => "rangle-reporting",
                                       "Authorization" => 'Basic WU5oMk15dkR3aVEyYzM2eDViYzZPQzBRVToyQXdpOEY1SXlyaGNzSWR1VWtUUGNVVjdSYXZhYUVqWGRleWRCRFRXS2huOFdia3lwRw==',
                                       "Content-Type" => "application/x-www-form-urlencoded;charset=UTF-8"})
    return 'Bearer ' + response["access_token"]
  end
end
