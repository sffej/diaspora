#   Copyright (c) 2012, David Morley.  This file is
#   licensed under the Affero General Public License version 3 or later.  See
#   the COPYRIGHT file.


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

