# Highlight a particular character of a string with an ASCII arrow.
#
#     HighlightColumn.new(line: 0, column: 14) do
#       "- include: lol://wut.yml"
#     end
#     => "- include: lol://wut.yml"
#        "              ^         "
#        "              here      "
class Eskimo::ASCII::HighlightColumn < Eskimo::ASCII::Component
  def initialize(
    column:,
    line:,
    markers: ['^', 'here'],
    style: [:bold, :red],
    &children
  )
    pastel = Pastel.new

    @colorize = ->(str) { pastel.decorate(str, *style) }
    @column = column
    @line = line
    @marker_padding = ' ' * @column
    @markers = markers

    super
  end

  def render(**)
    lines = super.lines
    line = lines[@line]

    unless line.nil? || line[@column].nil?
      lines[@line] = transform_line!(line, @column, &@colorize)
    end

    lines.join
  end

  protected

  def create_markers()
    buf = ''

    for marker in @markers do
      buf << @marker_padding + @colorize[marker] + "\n"
    end

    buf
  end

  def transform_line!(line, column, &fn)
    line[column] = fn[line[column]]
    line << "\n" unless line.end_with?("\n")
    line << create_markers
    line
  end
end
