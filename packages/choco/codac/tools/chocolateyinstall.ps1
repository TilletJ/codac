﻿$ErrorActionPreference = 'Stop'; # Stop on all errors.

# Source variables which are shared between install and uninstall.
. $PSScriptRoot\sharedVars.ps1

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$pp = Get-PackageParameters
$packageDir = Join-Path "$toolsDir" ".." -Resolve
$installDir = Join-Path "$packageDir" ".." -Resolve
if ($pp.InstallDir -or $pp.InstallationPath) { 
	$installDir = $pp.InstallDir + $pp.InstallationPath 
}
Write-Host "Codac is going to be installed in '$installDir'"

$root = Join-Path $installDir "codac"
New-Item -ItemType Directory -Force -Path $root | Out-Null

if (!$pp['url']) { 
	$url = 'https://github.com/lebarsfa/codac/releases/download/codac-1/codac_x86_mingw$MinGWMVer.zip'
	$checksum = 'EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE'
	$url64 = 'https://github.com/lebarsfa/codac/releases/download/codac-1/codac_x64_mingw$MinGWMVer.zip'
	$checksum64 = 'FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF'
	$packageArgs = @{
		packageName   = $env:ChocolateyPackageName
		unzipLocation = Join-Path "$root" ".."
		url           = $url
		url64bit      = $url64
		checksum      = $checksum
		checksumType  = 'sha256'
		checksum64    = $checksum64
		checksumType64= 'sha256'
	}
	Install-ChocolateyZipPackage @packageArgs

	$runtime = "mingw"
}
else {
	$url = $pp['url']
	#$checksum = $pp['sha256']
	$packageArgs = @{
		packageName   = $env:ChocolateyPackageName
		unzipLocation = Join-Path "$root" ".."
		url           = $url
		#checksum      = $checksum
		#checksumType  = 'sha256'
	}
	Install-ChocolateyZipPackage @packageArgs

	# Analyze url to guess what to add to Windows PATH...
	if ($url -match "x86") {
		$arch = "x86"
	}
	else {
		$arch = "x64"
	}
	if ($url -match "vc8") {
		$runtime = "vc8"
	}
	if ($url -match "vc9") {
		$runtime = "vc9"
	}
	elseif ($url -match "vc10") {
		$runtime = "vc10"
	}
	elseif ($url -match "vc11") {
		$runtime = "vc11"
	}
	elseif ($url -match "vc12") {
		$runtime = "vc12"
	}
	elseif ($url -match "vc14") {
		$runtime = "vc14"
	}
	elseif ($url -match "vc15") {
		$runtime = "vc15"
	}
	elseif ($url -match "vc16") {
		$runtime = "vc16"
	}
	elseif ($url -match "vc17") {
		$runtime = "vc17"
	}
	elseif ($url -match "vc18") {
		$runtime = "vc18"
	}
	else {
		$runtime = "mingw"
	}
}

if (!$pp['NoRegistry']) {
	New-Item "$CMakeSystemRepositoryPath\$CMakePackageName" -ItemType directory -Force
	New-ItemProperty -Name "CMakePackageDir" -PropertyType String -Value "$root\share\$CMakePackageName\cmake" -Path "$CMakeSystemRepositoryPath\$CMakePackageName" -Force
}
#$pathtoadd = "$root\bin"
#if (!($pp['NoPath']) -and !([environment]::GetEnvironmentVariable("Path","Machine") -match [regex]::escape($pathtoadd))) {
#	$newpath = [environment]::GetEnvironmentVariable("Path","Machine") + ";$pathtoadd"
#	[environment]::SetEnvironmentVariable("Path",$newpath,"Machine")
#}

for ($i = 1; $i -le 99; $i++) {
	if ($pp['url'+$i]) {
		$url = $pp['url'+$i]
		#$checksum = $pp['sha256']
		$packageArgs = @{
			packageName   = $env:ChocolateyPackageName
			unzipLocation = Join-Path "$root" ".."
			url           = $url
			#checksum      = $checksum
			#checksumType  = 'sha256'
		}
		Install-ChocolateyZipPackage @packageArgs

		# Analyze url to guess what to add to Windows PATH...
		if ($url -match "x86") {
			$arch = "x86"
		}
		else {
			$arch = "x64"
		}
		if ($url -match "vc8") {
			$runtime = "vc8"
		}
		if ($url -match "vc9") {
			$runtime = "vc9"
		}
		elseif ($url -match "vc10") {
			$runtime = "vc10"
		}
		elseif ($url -match "vc11") {
			$runtime = "vc11"
		}
		elseif ($url -match "vc12") {
			$runtime = "vc12"
		}
		elseif ($url -match "vc14") {
			$runtime = "vc14"
		}
		elseif ($url -match "vc15") {
			$runtime = "vc15"
		}
		elseif ($url -match "vc16") {
			$runtime = "vc16"
		}
		elseif ($url -match "vc17") {
			$runtime = "vc17"
		}
		elseif ($url -match "vc18") {
			$runtime = "vc18"
		}
		else {
			$runtime = "mingw"
		}

		if (!$pp['NoRegistry']) {
			New-Item "$CMakeSystemRepositoryPath\$CMakePackageName" -ItemType directory -Force
			New-ItemProperty -Name "CMakePackageDir" -PropertyType String -Value "$root\share\$CMakePackageName\cmake" -Path "$CMakeSystemRepositoryPath\$CMakePackageName" -Force
		}
		#$pathtoadd = "$root\bin"
		#if (!($pp['NoPath']) -and !([environment]::GetEnvironmentVariable("Path","Machine") -match [regex]::escape($pathtoadd))) {
		#	$newpath = [environment]::GetEnvironmentVariable("Path","Machine") + ";$pathtoadd"
		#	[environment]::SetEnvironmentVariable("Path",$newpath,"Machine")
		#}
	}
}
