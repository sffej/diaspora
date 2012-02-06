class Subdomain
  def self.matches?(request)
    case request.subdomain
    when 'www', '', nil, 'ecdhe-tls'
      false
    else
      true
    end
  end
end

