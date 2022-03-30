A usual Friday Night Funkin' engine with new stuff in it such as improved input system, ghost tapping, accuracy, and more.


BUILDING INSTRUCTIONS BELOW ↓↓

Installing The Required Programs:
- Haxe 4.1.5 (https://haxe.org/download/version/4.1.5/)
- HaxeFlixel (https://haxeflixel.com/documentation/install-haxeflixel/)
- VS Community 2019
- VS Code (optional)

Installing and Setup The Nessecary Libraries (open powershell or command prompt obviously):
- haxelib install flixel
- haxelib install flixel-addons
- haxelib install flixel-ui
- haxelib install hscript
- haxelib install newgrounds
- haxelib install lime 7.9.0
- haxelib install openfl
- haxelib run lime setup
- haxelib run lime setup flixel
- haxelib install flixel-tools
- haxelib run flixel-tools setup
- haxelib install linc_luajit

Installing Gits:
- Install git-scm (https://git-scm.com/downloads) 
- haxelib git polymod https://github.com/larsiusprime/polymod.git
- haxelib git discord_rpc https://github.com/Aidan63/linc_discord-rpc
- haxelib git faxe https://github.com/uhrobots/faxe

Installing Individual Components for VS Community 2019 (Required) (WINDOWS ONLY):
- MSVC v142 - VS 2019 C++ x64/x86 build tools
- Windows SDK (10.0.17763.0)
- C++ Profiling tools
- C++ CMake tools for windows
- C++ ATL for v142 build tools (x86 & x64)
- C++ MFC for v142 build tools (x86 & x64)
- C++/CLI support for v142 build tools (14.21)
- C++ Modules for v142 build tools (x64/x86)
- Clang Compiler for Windows
- Windows 10 SDK (10.0.17134.0)
- Windows 10 SDK (10.0.16299.0)
- MSVC v141 - VS 2017 C++ x64/x86 build tools
- MSVC v140 - VS 2015 C++ build tools (v14.00)

MacOS Dependencies (MAC USERS ONLY):
- You need to install Xcode (Go to the macOS App Store or by going to the link here: https://developer.apple.com/xcode/)
- If you're recieving an error that tells you to download the latest version of macOS, it's advised to install an older version (https://idmsa.apple.com/IDMSWebAuth/signin.html?path=%2Fdownload%2Fall%2F&appIdKey=891bd3417a7776362562d2197f89480a8547b108fd934911bcbea0110d07f757&rv=0)

Cloning The Repository:
- cd (i.e. C:\Users\username\Desktop or ~/Desktop) (Whatever you put the source code folder at)
- git clone https://github.com/DarkMoonPlayz1/DarkMoon-Engine-Official.git

Building Commands:
- lime build <target> (Whichever platform you want to build: windows, mac, linux, html5)
- You can find the build at DarkMoonEngine/export/release/<target>/bin including the <target> that you've build the code with
- If you want to access debug mode, do lime build <target> -debug
- You can find the debug version of the build by simply going to DarkMoonEngine/export/debug/<target>/bin
