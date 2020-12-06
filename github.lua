local Parameters = {...}

local Author = Parameters[1]
local Repository = Parameters[2]
local Branch = string.lower((type(Parameters[3])=="string" and Parameters[3]) or "master")
if Branch == "auto" then Branch = "master" end

if type(Author) ~= "string" or type(Repository) ~= "string" then
  print(string.format("%s: <Author> <Repository> [Branch:Auto] [Path]", shell.getRunningProgram()))
  return
end

shell.run("pastebin", "get", "4nRg9CHU", "temporary/json.lua")

local GIT_INFO_URL = string.format("https://api.github.com/repos/%s/%s/git/trees/%s?recursive=1", Author, Repository, Branch)
local CONTENT_URL = string.format("https://raw.githubusercontent.com/%s/%s/%s/", Author, Repository, Branch)

function GetRepositoryInfo()
  local Success = http.get(GIT_INFO_URL)
  if Success then
    local Contents = Success.readAll()
    Success.close()
    return true, Contents
  end
  return false
end

function GetFileContents(path)
  local Success = http.get(string.format(CONTENT_URL..path))
  if Success then
      local Contents = Success.readAll()
      Success.close()
      return true, Contents
  end
  return false
end

local Success, Files = GetRepositoryInfo()
