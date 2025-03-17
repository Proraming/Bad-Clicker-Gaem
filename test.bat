copy .\src\lib\UI.lua .\editor\UI.lua
xcopy /E /I /H /Y .\src\assets .\editor\assets

"C:\Program Files\LOVE\love.exe" ./editor/  --console
# in the name of the GREAT person
