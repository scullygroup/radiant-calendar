namespace :radiant do
  namespace :extensions do
    namespace :calendar do
      
      desc "Runs the migration of the Calendar extension"
      task :migrate => :environment do
        require 'radiant/extension_migrator'
        if ENV["VERSION"]
          CalendarExtension.migrator.migrate(ENV["VERSION"].to_i)
        else
          CalendarExtension.migrator.migrate
        end
      end
      
      desc "Copies public assets of the Calendar to the instance public/ directory."
      task :update => :environment do
        is_svn_or_dir = proc {|path| path =~ /\.svn/ || File.directory?(path) }
        puts "Copying assets from CalendarExtension"
        Dir[CalendarExtension.root + "/public/**/*"].reject(&is_svn_or_dir).each do |file|
          path = file.sub(CalendarExtension.root, '')
          directory = File.dirname(path)
          mkdir_p RAILS_ROOT + directory, :verbose => false
          cp file, RAILS_ROOT + path, :verbose => false
        end
      end  
    end
  end
end
