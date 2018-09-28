# ale-swift-syntax-check

 Simply check the swift code syntax in Vim

- for [ale](https://github.com/w0rp/ale) plugin
- with [swift-syntax-check](https://github.com/tokorom/swift-syntax-check)

## Installation

### with Vim package management

```sh
mkdir -p ~/.vim/pack/git-plugins/start
git clone https://github.com/w0rp/ale.git ~/.vim/pack/git-plugins/start/ale
git clone https://github.com/tokorom/ale-swift-syntax-check.git ~/.vim/pack/git-plugins/start/ale-swift-syntax-check
```

### with Volt

```sh
volt get w0rp/ale
volt get tokorom/ale-swift-syntax-check
```

## Required Configuration

```vim
let g:ale_fixers = {
\   'swift': ['swiftsyntaxcheck'],
\}

# with swiftlint
# let g:ale_fixers = {
# \   'swift': ['swiftlint', 'swiftsyntaxcheck'],
# \}
```

## Optional Configuration

```vim
" default
let g:ale_swift_syntax_check_swift_path = "swift"
```
