# frozen_string_literal: true

# Present the user with the closest possible correction, if any.
#
#     DidYouMean.new(dictionary: [ 'abc', 'bca' ], item: 'abd')
#     # => "hint: Did you mean? abc"
#
#     DidYouMean.new(dictionary: [ 'abc', 'bca' ], item: 'asdfasdf')
#     # => ""
#
# See https://github.com/yuki24/did_you_mean#using-the-didyoumeanspellchecker
class Eskimo::ASCII::DidYouMean < Eskimo::ASCII::Component
  attr_reader :corrections, :separator

  def initialize(dictionary:, item:, separator: " or ", &children)
    @corrections = ::DidYouMean::SpellChecker.new(
      dictionary: dictionary
    ).correct(item)

    @separator = separator

    super
  end

  def render(**)
    if corrections.any?
      "Did you mean? #{corrections.join(separator)}"
    end
  end
end
