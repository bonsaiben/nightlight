module Nightlight
  class Engine < ::Rails::Engine
    isolate_namespace Nightlight

    initializer "precompile" do |app|
      # use a proc instead of a string
      app.config.assets.precompile << Proc.new{|path| path =~ /\Anightlight\/application\.(js|css)\z/ }
    end

  end
end
