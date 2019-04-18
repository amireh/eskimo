module Eskimo
  module ASCII
  end
end

begin
  require 'did_you_mean'
rescue LoadError
end

require 'pastel'
require 'strings'
require 'tty-screen'

require 'eskimo/ascii/version'
require 'eskimo/ascii/constants'
require 'eskimo/ascii/component'
require 'eskimo/ascii/components/did_you_mean'
require 'eskimo/ascii/components/either'
require 'eskimo/ascii/components/gutter'
require 'eskimo/ascii/components/highlight'
require 'eskimo/ascii/components/highlight_column'
require 'eskimo/ascii/components/indent'
require 'eskimo/ascii/components/line_break'
require 'eskimo/ascii/components/soft_break'
require 'eskimo/ascii/components/spacer'
require 'eskimo/ascii/components/squeeze'
require 'eskimo/ascii/components/strip'
require 'eskimo/ascii/components/strip_left'
require 'eskimo/ascii/components/strip_right'
require 'eskimo/ascii/components/style'
require 'eskimo/ascii/components/truncate'
require 'eskimo/ascii/components/truncate_rear'
require 'eskimo/ascii/components/wrap'
