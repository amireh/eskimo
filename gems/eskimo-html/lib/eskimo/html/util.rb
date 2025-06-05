module Eskimo
  module HTML
    module Util
      TAG_NAME_START_CODEPOINTS	=	"@:A-Z_a-z\u{C0}-\u{D6}\u{D8}-\u{F6}\u{F8}-\u{2FF}\u{370}-\u{37D}\u{37F}-\u{1FFF}" \
        "\u{200C}-\u{200D}\u{2070}-\u{218F}\u{2C00}-\u{2FEF}\u{3001}-\u{D7FF}\u{F900}-\u{FDCF}" \
        "\u{FDF0}-\u{FFFD}\u{10000}-\u{EFFFF}"
      TAG_NAME_REPLACEMENT_CHAR	=	"_"
      TAG_NAME_FOLLOWING_CODEPOINTS	=	"#{TAG_NAME_START_CODEPOINTS}\\-.0-9\u{B7}\u{0300}-\u{036F}\u{203F}-\u{2040}"
      INVALID_TAG_NAME_FOLLOWING_REGEXP	=	/[^#{TAG_NAME_FOLLOWING_CODEPOINTS}]/
      INVALID_TAG_NAME_START_REGEXP	=	/[^#{TAG_NAME_START_CODEPOINTS}]/
      SAFE_XML_TAG_NAME_REGEXP	=	/\A[#{TAG_NAME_START_CODEPOINTS}][#{TAG_NAME_FOLLOWING_CODEPOINTS}]*\z/

      # ref: <https://api.rubyonrails.org/classes/ERB/Util.html#method-c-xml_name_escape>
      def self.xml_name_escape(name)
        name = name.to_s
        return "" if name.nil? || name == ''
        return name if name.match?(SAFE_XML_TAG_NAME_REGEXP)

        starting_char = name[0]
        starting_char.gsub!(INVALID_TAG_NAME_START_REGEXP, TAG_NAME_REPLACEMENT_CHAR)

        return starting_char if name.size == 1

        following_chars = name[1..-1]
        following_chars.gsub!(INVALID_TAG_NAME_FOLLOWING_REGEXP, TAG_NAME_REPLACEMENT_CHAR)

        starting_char << following_chars
      end
    end
  end
end
