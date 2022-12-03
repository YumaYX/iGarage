[オブジェクト指向スクリプト言語 Ruby リファレンスマニュアル (Ruby 3.1 リファレンスマニュアル)](https://docs.ruby-lang.org/ja/3.1/doc/index.html)

```ruby
x_dow    = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday']
```

```ruby
x_dow_jp = ['日', '月', '火', '水', '木', '金', '土']
```

```ruby
x_month  = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December']
```

# JSON

```ruby
require 'json'
```

## read

```ruby
JSON.load(File.read('file.json'))
```

```ruby
File.open(file_json) {|j| JSON.load(j)}
```

## write

```ruby
File.write('file.json', JSON.dump({}))
```

```ruby
File.open('file.json', 'w') {|f| JSON.dump({}, f)}
```

# CSV

```ruby
require 'csv'
```

```ruby
CSV.read(file_csv)
```

# File

## read

```ruby
File.read(file)
```

## write

```ruby
File.write(file, 'Hello')
```

# Date
```ruby
t = Time.now
t.strftime("%F") # => yyyy-mm-dd
```

# Hash
```ruby
hash = Hash.new(0)
hash['key'] += 1 # => 1
```

# ERB

```ruby
require 'erb'
```

## with value

```ruby
erb = ERB.new(File.read(file))
@val = 'val'
erb.result(binding)
```

## direct

```ruby
ERB.new(File.read(file)).result(binding)
```

# Markdown

```ruby
require 'redcarpet'
```

```ruby
# make html from markdown
# @param [String] markdown
# @return [String] html
def markdown_2_html(md)
  data = Redcarpet::Markdown.new(
    Redcarpet::Render::HTML,
    tables: true,
    autolink: true,
    fenced_code_blocks: true,
    lax_spacing: true,
    space_after_headers: true
  )
  data.render(md)
end
```

```ruby
rawdata = File.read(filename)
markdown_2_html(rawdata).gsub(/[\n]+/,"\n")
```

# digest

```ruby
require 'digest/sha2'
```

```ruby
Digest::SHA256.hexdigest(str)
```

---

# test

```ruby
require 'minitest/autorun'
require_relative './../lib/lib'
```

```ruby
class libTest < Minitest::Test
  def setup
  end

  def test_method
    assert_equal(expect, value)
    assert_match(/value/, value)
    assert_nil value
  end
end
```

