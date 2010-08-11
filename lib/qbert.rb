module QBert
  def self.version
    "0.1.0"
  end

  class Runner
    attr_reader :contents

    def initialize(contents)
      @contents = contents
    end

    def run
      eval(self.contents)
    end

    def it(description, opts={}, &blk)
      Config.new(description, opts, &blk).run
    end
  end

  class Config
    class NotImplemented < StandardError; end

    attr_reader :description

    def initialize(description, opts={}, &blk)
      @description = description
      @retry = opts[:retry] || 3
      blk.call(self) if blk
    end

    def run
      @retry.times do
        break if verified?
        @crank_blk.call
      end
    end

    def verified?
      !!@verify_blk.call
    end

    def verify(&blk)
      @verify_blk = blk || lambda { raise NotImplemented, "verify is not implemented" }
    end

    def crank(&blk)
      @crank_blk = blk || lambda { raise NotImplemented, "crank is not implemented" }
    end
  end
end
