function up --wraps='archtools update -u --log debug' --description 'upgrade all packages'
	archtools update -u --waybar --log debug
end
