@echo off
setlocal

set folder=%~dp0src
set markdown_file=./README.md
set replace_str=https://shurintou.github.io/my-code-memos/src

(
echo.
for /r "%folder%" %%i in (*) do (
  if "%%~ai" NEQ "d" echo %%~fi
)
) > "%markdown_file%.tmp"


setlocal EnableDelayedExpansion
set "file_contents="

for /f "usebackq delims=" %%x in ("%markdown_file%.tmp") do (
    set "line=%%x"
    set "relative_path=!line:%folder%=!"
    if "!relative_path:~-1!"=="\" set "relative_path=!relative_path:~0,-1!"
    set "line=!line:%folder%=%replace_str%!"
    if defined prev_line (
      set "markdown_link=<br/>[!relative_path!](!line!)"
    ) else (
      set "markdown_link=[!relative_path!](!line!)"
    )
    set "prev_line=!line!"
    set "file_contents=!file_contents!!markdown_link!"
)

set "file_contents=!file_contents:\=/!/"
set "file_contents=!file_contents:%%20/=/!"
set "file_contents=!file_contents:~0,-1!"
echo !file_contents! > "%markdown_file%"

del "%markdown_file%.tmp"

set "title=my-code-memos"
set "subtitle=This is a repository that stores some useful codes during my coding experience."
(for /l %%i in (1,1,2) do (
  if %%i==1 (echo # !title!) else (echo !subtitle!)
  echo.
)) > "%markdown_file%.tmp"

type "%markdown_file%.tmp" "%markdown_file%" > "%markdown_file%.tmp2"

move /y "%markdown_file%.tmp2" "%markdown_file%" > nul

del "%markdown_file%.tmp"

echo "The markdown header added to %markdown_file%"