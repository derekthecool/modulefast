# Copyright (c) Derek Lomax - All Rights Reserved
# You may use, distribute and modify this code under the
# terms of the MIT license.

using module AnyPackage
using namespace AnyPackage.Provider
using namespace NuGet.Versioning
using namespace System.Management.Automation

[PackageProvider('Npm')]
class NpmProvider : PackageProvider, IFindPackage, IInstallPackage
{
    [void] FindPackage([PackageRequest] $request)
    {
        $searchResults = & npm search $request.Name --json | ConvertFrom-Json

        $searchResults | Write-Package -Request $request
    }

    [void] InstallPackage([PackageRequest] $request)
    {
        & sudo npm install -g $request.Name
    }

    [object] GetDynamicParameters([string] $commandName)
    {
        return $(switch ($commandName)
            {
                'Find-Package'
                { [FindPackageDynamicParameters]::new() 
                }
                'Install-Package'
                { [InstallPackageDynamicParameters]::new() 
                }
                default
                { $null 
                }
            })
    }

    [string] RemoveSpec([string] $spec)
    {
        $spec = $spec -replace '!', ''

        if ($spec.Contains('>='))
        {
            return $spec.Split('>=')[0]
        } elseif ($spec.Contains('<='))
        {
            return $spec.Split('<=')[0]
        } elseif ($spec.Contains('='))
        {
            return $spec.Split('=')[0]
        } elseif ($spec.Contains(':'))
        {
            return $spec.Split(':')[0]
        } elseif ($spec.Contains('<'))
        {
            return $spec.Split('<')[0]
        } elseif ($spec.Contains('>'))
        {
            return $spec.Split('>')[0]
        } else
        {
            return $spec
        }
    }
}

class FindPackageDynamicParameters
{
    [Parameter()]
    [switch] $Update
}

class InstallPackageDynamicParameters
{
    [Parameter()]
    [string] $Destination

    [Parameter()]
    [int] $ThrottleLimit

    [Parameter()]
    [string] $CILockFilePath

    [Parameter()]
    [switch] $Update

    [Parameter()]
    [switch] $NoProfileUpdate

    [Parameter()]
    [switch] $NoPSModulePathUpdate
}

[guid] $id = 'fdafe383-4764-4663-9c53-ec0f30678a6d'
[PackageProviderManager]::RegisterProvider($id, [NpmProvider], $MyInvocation.MyCommand.ScriptBlock.Module)

$MyInvocation.MyCommand.ScriptBlock.Module.OnRemove = {
    [PackageProviderManager]::UnregisterProvider($id)
}

function Write-Package
{
    [CmdletBinding()]
    param (
        [Parameter(ValueFromPipelineByPropertyName)]
        [string]
        $name,

        [Parameter(ValueFromPipelineByPropertyName)]
        [string]
        $version,

        [Parameter(ValueFromPipelineByPropertyName)]
        [string]
        $description,

        [Parameter(ValueFromPipelineByPropertyName)]
        [string]
        $license,

        [Parameter(ValueFromPipelineByPropertyName)]
        [string]
        $date,

        # [Parameter(ValueFromPipelineByPropertyName)]
        # [string]
        # $sanitized_name,
        #
        # [Parameter(ValueFromPipelineByPropertyName)]
        # [hashtable]
        # $publisher,
        #
        # [Parameter(ValueFromPipelineByPropertyName)]
        # [hashtable[]]
        # $maintainers,
        #
        # [Parameter(ValueFromPipelineByPropertyName)]
        # [hashtable]
        # $links,

        [Parameter(Mandatory)]
        [PackageRequest]
        $Request
    )

    process
    {
        $metadata = @{
            License = $license
            SanitizedName = $sanitized_name
            Date = $date
            # Publisher = $publisher
            # Maintainers = $maintainers
            # Links = $links
        }
        $source = [PackageSourceInfo]::new($name, 'test', $Request.ProviderInfo)
        $package = [PackageInfo]::new($name, $version, $source, $description, $null, $metadata, $Request.ProviderInfo)
        $Request.WritePackage($package)
    }
}
