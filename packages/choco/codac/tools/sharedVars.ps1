if ((Get-ProcessorBits 32) -or $env:ChocolateyForceX86 -eq $true) { $arch = "x86" } else { $arch = "x64" }
$MinGWMVer = "11"
$CMakeRegistryPath = "HKCU:\SOFTWARE\Kitware\CMake"
$CMakeSystemRepositoryPath = "HKLM:\SOFTWARE\Kitware\CMake\Packages"
$CMakePackageName = "Codac"
