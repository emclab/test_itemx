module TestItemx
  class Engine < ::Rails::Engine
    isolate_namespace TestItemx
    config.generators do |g|
      #g.orm             :active_record
      #g.template_engine :erb
      g.test_framework  :rspec, :view_specs => false
    end
  end
end
