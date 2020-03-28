# dotfiles

## Installation

```bash
$ curl -sL https://dot.raba.me | sh
```

## Development

[Tasks](./maskfile.md)

### cookbook内の実行順

default.rb 以外はファイルが存在する場合のみ実行

1. pre_exec.rb
2. default.rb
3. manjaro.rb
4. darwin.rb
5. post_exec.rb
