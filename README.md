rspec-like syntax to perform & verify system commands, or other stuff.

    it "creates a directory" do |m|
      m.verify do
        File.exists?('/tmp/what')
      end

      m.crank do
        system("mkdir -p /tmp/what")
      end
    end
