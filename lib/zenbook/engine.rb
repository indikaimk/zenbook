module Zenbook
  class Engine < ::Rails::Engine
    isolate_namespace Zenbook

    # initializer "zenbook.assets" do |app|
    #   # my_engine/app/javascript needs to be in the asset path
    #   app.config.assets.paths << root.join("app/javascript")

    # end
  end
end
