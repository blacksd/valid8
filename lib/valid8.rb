require 'yaml'
require 'pry'
require 'pry-byebug'
require 'awesome_print'

class Valid8
  attr_reader :settings
  ALLOWED_TYPES=["mx","a","cname","txt","ns"]

  # TODO:
  # - logger
  def initialize(settings_path,domain)

    if File.file?(settings_path)
      raise ArgumentError,"The specified file does not have a .yml or .yaml extension." unless [".yml", ".yaml"].include? File.extname(settings_path)
      raise ArgumentError,"The specified file is empty." if File.size(settings_path) == 0
      config_files = [ settings_path ]
    elsif File.directory?(settings_path)
      config_files = Dir.glob("#{settings_path.chomp("/")}/*.{yml,yaml}").reject{ |file| File.size(file) == 0  }
      raise ArgumentError,"The specified path does not contain any non-empty .yml or .yaml file." if config_files.empty?
    else
      raise ArgumentError,"The specified string does not look like a file or a directory."
    end
    # TODO:
    # - validate domain


    # binding.pry
    parse_config(config_files)
  end

  def parse_config(config)
    #  TODO:
    # - load directly yaml instead of file
    # - hash deep merge for multiple files loads

    config.each do |config_file|
      @settings = YAML.load_file(config_file)
      raise "The file #{config_file} does not a valid YAML syntax." unless @settings.instance_of? Hash
    end if config.instance_of? Array
    #  TODO:
    # - validate syntaxes!
    # - flatten

    # at this point, the records are plain and standard

    #  TODO:
    # - raise if not found
    # - transformation_hash?
    @settings["records"].each do |record|
      record.each do |_,value|
        value.gsub!(/{{ (.*) }}/) { |match|
          # TODO if it matches a "record." placeholder
          @settings["variables"][$1]
        } if value.instance_of? String
      end

    end
  end

end
