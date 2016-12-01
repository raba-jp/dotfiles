function is_docker_machine_running() { [ (docker-machine status) = 'Running' ]; }

function set_env_docker_machine() {
  ! is_exist 'docker-machine' && return 1
  if ! is_docker_machine_running; then
    docker-machine start default
  fi
  eval $(docker-machine env)
}

set_env_docker_machine
