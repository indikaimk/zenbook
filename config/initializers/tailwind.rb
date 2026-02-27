Rails.application.config.tap do |config|
  # Initialize the tailwind_content_paths array if not already set by engines
  unless config.respond_to?(:tailwind_content_paths)
    config.class.attr_accessor :tailwind_content_paths
  end
end