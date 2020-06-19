class HTTP::Server::Context
  @_browser : Browser::Base?

  def browser : Browser::Base
    headers = request.headers
    @_browser ||= Browser.new(headers.fetch("User-Agent", nil),
                              accept_language: headers.fetch("Accept-Language", nil))
  end
end
