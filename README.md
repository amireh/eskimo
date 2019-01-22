# Eskimo

Declarative text formatting for Ruby.

```ruby
class Banner
  include Eskimo::Components

  def render(**)
    Indent.new(width: 4) do
      Style.new(style: [:bold, :green]) do
        'Welcome!'
      end
    end
  end
end

Eskimo::Renderer.new.apply do
  Component.new
end
# => "    Welcome!"
```

Pass properties to the renderer and use them in components:

```ruby
class FormattedError
  include Eskimo::Components

  def render(error:, **)
    [
      Style.new(:red, :bold) do
        "error: "
      end,

      Indent.new(width: 'error: '.length) do
        error.message
      end
    ]
  end
end

Eskimo::Renderer.new(error: StandardError.new("welp!")).apply do
  FormattedError.new
end # => "error:
    #            welp!"
```

Customize components with parameters (they're Ruby objects after-all):

```ruby
class FormattedError
  include Eskimo::Components

  def initialize(style: [:red])
    @style = style
  end

  def render(error:, **)
    [
      Style.new(*@style) { 'oops! ' },
      Style.new(:bold) { error.message }
    ]
  end
end

Eskimo::Renderer.new(error: StandardError.new).apply do
  FormattedError.new(style: [:red, :bold])
  #                  ^^^^^^^^^^^^^^^^^^^^
end
```

Compose everything:

```ruby
include Eskimo::Components

Eskimo::Renderer.new(error: StandardError.new).apply do
  Indent.new(width: 4) do
    [
      ErrorHeader.new(style: [:red, :bold]),
      
      LineBreak.new,

      Indent.new(width: 4) do
        Wrap.new(width: 72) do |error:, **|
          error.message
        end
      end
    ]
  end
end

class ErrorHeader
  ...
end
```

It's all Ruby, you choose:

```ruby
as_a_proc = lambda { |name:, **| "Hello, #{name!}" }
as_a_duck = Indent.new(width: 4) { |name:, **| "Hello, #{name}!" }
as_a_string = 'Who is this?'

Eskimo::Renderer.new(name: 'Kiksi').apply do
  [ as_a_proc, ' ', as_a_duck, ' ', as_a_string ]
end
# => "Hello, Kiksi! Hello, Kiksi! Who is this?"
```

## Installation

    gem install eskimo

## API

### `Renderer.new(?props: Hash): Renderer`

Create an instance of the Renderer with the properties you want to expose to
components (if any).

### `Renderer#apply(&component): String`

Convert a component into a String. A component may be:

- A string
- An array of components
- A lambda that accepts a Hash and returns a component
- An object that responds to `render`, accepting a Hash and returning a 
  component

A component may render others. This is done by means of calling the special
`render` lambda that is passed to components:

```ruby
component = lambda do |render:, **|
  string = render['   a', 'b'] # => " ab"
  string.strip
end

render { component } # => "ab"
```

Although a more useful example would be when your component accepts children:

```ruby
def component(&children)
  lambda do |render:, **|
    string = render[children]
    string.strip
  end
end

render { component { ['   a', 'b'] } } # => "ab"
```

Even though you're not technically tied to accepting children in a block, it's
recommended to do so for consistency with the base Eskimo components.

### `Component.new(&children: Proc): Component`

A convenience base class that allows you to render children with a mere call to
`super` in your `render` routine:

```ruby
class MyCompositeComponent < Eskimo::Component
  def render(**)
    string = super
    string.strip
  end
end

render { MyCompositeComponent.new { ['   a', 'b'] } } # => "ab"
```

Refer to the implementation of the existing Eskimo components for guidance.

## Components

See the accompanying [API documentation][component-reference].

## License

MIT

[component-reference]: https://amireh.github.io/eskimo/Eskimo/Components.html
