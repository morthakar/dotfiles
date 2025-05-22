function jlog --wraps='journalctl -p 3 -xb' --description 'alias jctl=journalctl -p 3 -xb'
  journalctl -p 3 -xb | bat -l log
end
