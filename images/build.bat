
@echo off

if "%1" == "" (
	echo Usage: build.bat [folder]
) ELSE IF NOT EXIST "%1" (
	echo %1: No such file or directory
) ELSE (
	cd %1

	IF EXIST "thumbs" (
		cd thumbs
		del /F /Q *
		cd ..
	) ELSE (
		mkdir thumbs
	)
	cd ..
)
