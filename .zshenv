GOPATH=$HOME/go
RBPATH=$HOME/.rbenv/bin
PYPATH=$HOME/.pyenv/bin
NDPATH=$HOME/.nodebrew/current/bin

path=(
  $GOPATH(N-/)
  $RBPATH(N-/)
  $PYPATH(N-/)
  $NDPATH(N-/)
  $path
)
