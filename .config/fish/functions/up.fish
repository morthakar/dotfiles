function up --wraps='paru -Syu && polybar-msg cmd restart' --description 'alias up=paru -Syu && polybar-msg cmd restart'
  paru -Syu && polybar-msg cmd restart $argv; 
end
