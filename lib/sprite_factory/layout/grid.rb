module SpriteFactory
  module Layout
    module Grid

      #------------------------------------------------------------------------

      def self.layout(images, options = {})

        raise NotImplementedError, ":grid layout does not support fixed :width/:height option" if options[:width] || options[:height]
        raise NotImplementedError, ":grid layout require :columns option" if !options[:columns]

        return { :width => 0, :height => 0 } if images.empty?

        hpadding = options[:hpadding] || 0
        vpadding = options[:vpadding] || 0
        hmargin  = options[:hmargin]  || 0
        vmargin  = options[:vmargin]  || 0
        max_columns = options[:columns].to_i

        images.each do |i|
          i[:w] = i[:width]  + (2*hpadding) + (2*hmargin)
          i[:h] = i[:height] + (2*vpadding) + (2*vmargin)
        end

        max_width = images.map{|i| i[:w]}.max
        max_height = images.map{|i| i[:h]}.max

        # Sort by filename
        images.sort! do |a,b|
          a[:name] <=> b[:name]
        end

        row = 0
        column = 0
        images.each do |i|
          if column >= max_columns
            column = 0
            row += 1
          end
          i[:x] = column * max_width
          i[:y] = row * max_height
          i[:cssw] = max_width
          i[:cssx] = i[:x]
          i[:cssh] = max_height
          i[:cssy] = i[:y]
          column += 1
        end

        { :width => max_columns * max_width, :height => (row+1)*max_height }

      end

    end # module Grid
  end # module Layout
end # module SpriteFactory
