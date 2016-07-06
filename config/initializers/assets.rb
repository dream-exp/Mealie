# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

Rails.application.config.assets.precompile += %w( style.css )

Rails.application.config.assets.precompile += %w( jquery.js )

Rails.application.config.assets.precompile += %w( script.js )

Rails.application.config.assets.precompile += %w( index_style.css )


Rails.application.config.assets.precompile += %w( payments.css )

Rails.application.config.assets.precompile += %w( administration.css )

Rails.application.config.assets.precompile += %w( statistics.css )

Rails.application.config.assets.precompile += %w( logins.js )

Rails.application.config.assets.precompile += %w( payments.js )

Rails.application.config.assets.precompile += %w( administration.js )

Rails.application.config.assets.precompile += %w( menus.js )
# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
