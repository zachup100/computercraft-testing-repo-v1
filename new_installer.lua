local Index = {...}
local Author = Index[1]
local Repository = Index[2]
local _Program = shell.getRunningProgram()
if not Author or not Repository then print(string.format("%s", _Program)) end
