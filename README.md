# Spotlight

Search engine parsing for Crystal. Inspired by the [search-engine-parser](https://github.com/bisoncorps/search-engine-parser) Python library. Currently includes support for:

- Google
- Bing
- DuckDuckGo

## Installation

1. Add the dependency to your `shard.yml`:

   ```yaml
   dependencies:
     spotlight:
       github: watzon/spotlight
   ```

2. Run `shards install`

## Usage

```crystal
require "spotlight"

ddg = Spotlight::DuckDuckGo.new
ddg.search("crystal language")
# => [#<Spotlight::Result:0x7fd6a131f090
#     @desc= "Type system. Crystal is statically type checked, so any type errors will be caught early by the compiler rather than fail on runtime. Moreover, and to keep the language clean, Crystal has built-in type inference, so most type annotations are unneeded.",
#     @link="https://crystal-lang.org/",
#     @title="Crystal">, ...]
```

## Contributing

1. Fork it (<https://github.com/watzon/spotlight/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Chris Watson](https://github.com/watzon) - creator and maintainer
