class Valid8
  attr_reader :settings

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
    config_files
  end
end
