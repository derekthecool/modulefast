@{
    RootModule = 'AnyPackage.ModuleFast.psm1'
    ModuleVersion = '0.1.1'
    CompatiblePSEditions = @('Desktop', 'Core')
    GUID = '95ea8d7f-586e-42e1-83b2-2688f02d42e9'
    Author = 'Thomas Nieto'
    Copyright = '(c) 2024 Thomas Nieto. All rights reserved.'
    Description = 'ModuleFast provider for AnyPackage.'
    PowerShellVersion = '5.1'
    RequiredModules = @(
        @{ ModuleName = 'AnyPackage'; ModuleVersion = '0.5.1' },
        @{ ModuleName = 'ModuleFast'; ModuleVersion = '0.1.2' })
    FunctionsToExport = @()
    CmdletsToExport = @()
    AliasesToExport = @()
    PrivateData = @{
        AnyPackage = @{
            Providers = 'ModuleFast'
        }
        PSData = @{
            Tags = @('AnyPackage', 'Provider', 'ModuleFast', 'Windows')
            LicenseUri = 'https://github.com/anypackage/modulefast/blob/main/LICENSE'
            ProjectUri = 'https://github.com/anypackage/modulefast'
        }
    }
    HelpInfoURI = 'https://go.anypackage.dev/help'
}
