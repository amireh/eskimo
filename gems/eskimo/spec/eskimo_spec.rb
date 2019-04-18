# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Eskimo do
  it 'includes eskimo-core' do
    expect(Eskimo.constants).to include(:Core)
  end
  it 'includes eskimo-ascii' do
    expect(Eskimo.constants).to include(:ASCII)
  end
end
