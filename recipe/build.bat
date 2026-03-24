@echo on

pushd src\cmd\syft

go-licenses save . ^
    --save_path "%SRC_DIR%\library_licenses" ^
    --ignore modernc.org/mathutil ^
    --ignore github.com/xi2/xz ^
    --ignore github.com/deitch/magic/pkg/magic ^
    --ignore github.com/deitch/magic/pkg/magic/internal ^
    --ignore github.com/deitch/magic/pkg/magic/parser
if errorlevel 1 exit 1

go build ^
    -v ^
    -o "%LIBRARY_BIN%\syft.exe" ^
    -ldflags="-X 'main.version=%PKG_VERSION%'"
if errorlevel 1 exit 1

popd

:: Clear out cache to avoid file not removable warnings
for /f "delims=" %%i in ('go env GOPATH') do set "GOPATH_DIR=%%i"
rmdir /s /q "%GOPATH_DIR%"
