function orbstack-perfmon --description 'Top of what consumes most CPU in OrbStack'
  docker run -it --rm --pid host alpine sh -c 'apk add htop && htop'
end
