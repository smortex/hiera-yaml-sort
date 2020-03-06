# frozen_string_literal: true

module HieraYamlSort
  class HieraYamlFile
    attr_reader :filename, :root

    def initialize(filename)
      @filename = filename
      read
    end

    def read
      @root = HieraYamlLine.new('')
      lastref = [@root]

      File.read(filename).lines.each do |line|
        level = line.match(/\A */)[0].length / 2 + 1

        item = HieraYamlLine.new(line)

        lastref[level - 1].add_child(item)
        lastref[level] = item
      end
    end

    def to_s
      root.to_s
    end

    def write
      File.write(filename, to_s)
    end
  end
end
