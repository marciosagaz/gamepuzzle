local function make()
	os.execute('cd src && zip -r ../bin/gamelua.love *')
	os.execute('cd bin && pwd && love gamelua.love')
end

make()