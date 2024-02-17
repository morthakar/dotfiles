function updatefc --wraps='sudo fc-cache -fv' --description 'alias updatefc=sudo fc-cache -fv'
  sudo fc-cache -fv $argv; 
end
