begin
  require 'did_you_mean'
rescue LoadError
end

require 'pastel'
require 'strings'
require 'tty-screen'

require 'eskimo/version'

require 'eskimo/constants'

require 'eskimo/component'
require 'eskimo/renderer'

require 'eskimo/components/did_you_mean'
require 'eskimo/components/either'
require 'eskimo/components/gutter'
require 'eskimo/components/highlight'
require 'eskimo/components/highlight_column'
require 'eskimo/components/indent'
require 'eskimo/components/line_break'
require 'eskimo/components/soft_break'
require 'eskimo/components/spacer'
require 'eskimo/components/squeeze'
require 'eskimo/components/strip'
require 'eskimo/components/strip_left'
require 'eskimo/components/strip_right'
require 'eskimo/components/style'
require 'eskimo/components/truncate'
require 'eskimo/components/truncate_rear'
require 'eskimo/components/wrap'
