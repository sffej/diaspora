class Subdomain
  def self.matches?(request)
    case request.subdomain
    when 'www', '', nil, 'unicorn'
      false
    else
      true
    end
  end
end

