REM MIT License

REM Copyright (c) 2025 Fearedfusionx

REM Permission is hereby granted, free of charge, to any person obtaining a copy
REM of this software and associated documentation files (the "Software"), to deal
REM in the Software without restriction, including without limitation the rights
REM to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
REM copies of the Software, and to permit persons to whom the Software is
REM furnished to do so, subject to the following conditions:

REM The above copyright notice and this permission notice shall be included in all
REM copies or substantial portions of the Software.

REM THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
REM IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
REM FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
REM AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
REM LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
REM OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
REM SOFTWARE.


@echo off
del OUT_VIDEO.MP4
CLS
setlocal
title Shittify: Make your videos shit
:: Display a simple ASCII Art banner

echo [------------------------------------------------]
echo   SSSSS  hh      iii tt    tt    iii  fff yy   yy        
echo  SS      hh          tt    tt        ff   yy   yy 
echo   SSSSS  hhhhhh  iii tttt  tttt  iii ffff  yyyyyy 
echo       SS hh   hh iii tt    tt    iii ff        yy 
echo   SSSSS  hh   hh iii  tttt  tttt iii ff    yyyyyy
echo [------------------------------------------------]
echo A stupid ass shit low budget maker for Videos.
echo By FearedFusionX
echo _________________________________________________________________________________

:: Run PowerShell to open a file picker and get the selected file
for /f "delims=" %%i in ('powershell -command "Add-Type -AssemblyName System.Windows.Forms; $file = New-Object System.Windows.Forms.OpenFileDialog; $file.filter = 'Video Files|*.mp4;*.mkv;*.avi;*.mov'; if($file.ShowDialog() -eq 'OK'){echo $file.FileName}" 2^>^&1') do set "inputFile=%%i"

:: Check if a file was selected
if "%inputFile%"=="" (
    powershell -command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.MessageBox]::Show('No file selected, dumbass.', 'Bruh')"
    exit /b
)

:: Run PowerShell to open a Save As dialog for output file selection
for /f "delims=" %%i in ('powershell -command "Add-Type -AssemblyName System.Windows.Forms; $save = New-Object System.Windows.Forms.SaveFileDialog; $save.Filter = 'MP4 Files|*.mp4'; $save.DefaultExt = 'mp4'; if($save.ShowDialog() -eq 'OK'){echo $save.FileName}" 2^>^&1') do set "outputFile=%%i"

:: Check if an output file was selected
if "%outputFile%"=="" (
    powershell -command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.MessageBox]::Show('You didn't select the Output Directory.', 'Closing')"
    exit /b
)

:: Run ffmpeg with visible console
ffmpeg -i "%inputFile%" -vf "scale=100:100" -b:v 200k -r 10 -ar 8000 -ac 1 -b:a 16k "OUT_VIDEO.MP4"
ffmpeg -i "OUT_VIDEO.MP4" -vf "scale=1920:1080" -b:v 200k -r 10 -ar 8000 -ac 1 -b:a 16k %outputFile%
del OUT_VIDEO.MP4
pause

:: Check if ffmpeg succeeded
if errorlevel 1 (
    powershell -command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.MessageBox]::Show('Failed to process the video.', 'OH SHIT')"
    exit /b
)

:: Success notification
echo _________________________________________________________________________________
echo %outputFile% was successfully shittified!
powershell -command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.MessageBox]::Show('Your Shitty Ass video, %outputFile%, has successfully shittified itself.', 'Shittified')"


exit /b
