require 'open3'

module MscFiddle
  class MscGen
    RenderingError = Class.new(StandardError)

    def initialize(msc)
      @msc = msc
    end

    def to_svg
      result, log, status = Open3.capture3('mscgen -T svg -i - -o -', stdin_data: @msc)

      if status.success?
        return result
      else
        raise RenderingError.new(log)
      end
    end
  end
end
