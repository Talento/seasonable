module Seasonable
  class Engine < ::Rails::Engine
    # Use minitest-spec by default
    config.generators do |g|
      g.test_framework :minitest, spec: true, fixture: false
    end
  end
end
