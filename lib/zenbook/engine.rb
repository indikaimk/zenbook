module Zenbook
  class Engine < ::Rails::Engine
    isolate_namespace Zenbook

    initializer "zenbook.importmap", before: "importmap" do |app|
      # https://github.com/rails/importmap-rails#composing-import-maps
      app.config.importmap.paths << root.join("config/importmap.rb")

      # https://github.com/rails/importmap-rails#sweeping-the-cache-in-development-and-test
      app.config.importmap.cache_sweepers << root.join("app/javascript")
    end

    initializer "zenbook.assets" do |app|
      # my_engine/app/javascript needs to be in the asset path
      app.config.assets.paths << root.join("app/javascript")

    end

    initializer "zenbook.tailwind" do |app|
      app.config.tailwind_content_paths ||= []
      app.config.tailwind_content_paths += [
        root.join("app/views/**/*.{erb,slim}").to_s,
        root.join("app/components/**/*.rb").to_s,
        root.join("app/helpers/**/*.rb").to_s,
        root.join("app/javascript/**/*.js").to_s
      ]
    end
  end
end
