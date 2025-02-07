function up --wraps='paru -Syu && polybar-msg cmd restart' --description 'alias up=paru'
	begin
		 archtools update -icnf
	end
end
