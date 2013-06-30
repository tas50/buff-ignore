module Buff
  module Ignore
    # A Ruby representation of an ignore file
    class IgnoreFile
      # Regular expression to match comments or plain whitespace
      #
      # @return [Regexp]
      COMMENT_OR_WHITESPACE = /^\s*(?:#.*)?$/.freeze

      # The path to the ignore file
      #
      # @return [String]
      attr_reader :filepath

      # Create a new ignore file from the given filepath
      #
      # @raise [IgnoreFileNotFound]
      #   if the given filepath does not exist
      #
      # @param [#to_s] filepath
      #   the path to the ignore file
      def initialize(filepath)
        @filepath = File.expand_path(filepath.to_s)
        raise IgnoreFileNotFound.new(filepath) unless File.exists?(filepath)
      end

      # Apply the ignore to the list, returning a new list of filtered files
      #
      # @example
      #   files = ['Gemfile', 'Gemfile.lock', 'bacon', 'eggs']
      #   ignore.apply(files) #=> ['bacon', 'eggs']
      #
      # @see IgnoreFile#apply!
      #
      # @param [Array] list
      #   the list of files to apply the ignore to
      #
      # @return [Array]
      #   the sanitized file list
      def apply(list)
        tmp = list.dup
        apply!(tmp)
        tmp
      end

      # Destructively remove all files from the given list
      #
      # @param [Array] list
      #   the list of files to apply the ignore to
      #
      # @return [Array, nil]
      #   the elements removed, or nil if none were removed
      def apply!(list)
        list.reject! do |item|
          item.strip.empty? || ignored?(item)
        end
      end

      private
        # The parsed contents of the ignore file
        #
        # @return [Array]
        def ignores
          @ignores ||= File.readlines(filepath).reject do |line|
            line.strip.empty? || line.strip =~ COMMENT_OR_WHITESPACE
          end
        end

        # Helper boolean to determine if a given filename should be ignored
        #
        # @param [String] filename
        #   the file to match
        #
        # @return [Boolean]
        #   true if the file should be ignored, false otherwise
        def ignored?(filename)
          ignores.any? { |ignore| File.fnmatch?(ignore, filename) }
        end
    end
  end
end
