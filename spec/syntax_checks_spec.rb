require_relative ('../lib/valid8.rb')

describe Valid8 do
zone_to_test = "domain.com"
base_path = "tests/"
config_path = base_path + "configs/"

  describe '#initialize' do

    context "with an invalid path" do
      empty_dir = config_path + "empty_dir/"
      empty_file = config_path + "empty.yml"
      fake_dir = config_path + "fakedirlol/"
      fake_file = config_path + "fakefilelol.yml"
      real_file_notyaml = config_path + "not_a_yaml_file.txt"

      it "fails if the path is not a file or a directory" do
        expect { Valid8.new(fake_file,zone_to_test) }.to raise_error ArgumentError,"The specified string does not look like a file or a directory."
        expect { Valid8.new(fake_dir,zone_to_test) }.to raise_error ArgumentError,"The specified string does not look like a file or a directory."
      end

      it "fails if the file path don't have .yml or .yaml extension" do
        expect { Valid8.new(real_file_notyaml,zone_to_test) }.to raise_error ArgumentError,"The specified file does not have a .yml or .yaml extension."
      end

      it "fails if the path is an empty file or directory" do
        expect { Valid8.new(empty_file,zone_to_test) }.to raise_error ArgumentError,"The specified file is empty."
        expect { Valid8.new(empty_dir,zone_to_test) }.to raise_error ArgumentError,"The specified path does not contain any non-empty .yml or .yaml file."
      end

    end

    context "with a valid path" do
      it "parses a single .yml or .yaml file"
      it "parses .yml and .yaml files in a directory"

      context "and an invalid syntax" do
        it "fails if any of the files is not YAML compliant"
        it "fails if the records miss any parameter and there's no default"
      end

      # it "builds a Valid8 instance"
      context "and a 'type a' syntax" do
        it "fails if there is a duplicate type"
      end
    end
  end
end
