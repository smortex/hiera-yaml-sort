# frozen_string_literal: true

module HieraYamlSort
  class HieraYamlLine
    attr_reader :content, :children

    def initialize(content, children = [])
      @content = content
      @children = children
    end

    def add_child(item)
      @children.push(item)
    end

    def to_s(root = true, sort = true)
      if root
        children.sort.map { |c| c.to_s(false) }.join
      else
        res = content

        if children.any?
          sort &= !scalar_block?

          res += children_content(sort)
        end

        res
      end
    end

    def <=>(other)
      return -1 if content == "---\n"
      return 1 if other.content == "---\n"

      return -1 if content == "lookup_options:\n"
      return 1 if other.content == "lookup_options:\n"

      content <=> other.content
    end

    private

    def scalar_block?
      content.match?(/(\||>)-?\n\z/)
    end

    def children_content(sort)
      if sort
        children.sort.map { |c| c.to_s(false, sort) }.join
      else
        children.map { |c| c.to_s(false, sort) }.join
      end
    end
  end
end
