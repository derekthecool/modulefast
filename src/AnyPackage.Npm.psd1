@{
    RootModule = 'AnyPackage.Npm.psm1'
    ModuleVersion = '0.1.0'
    CompatiblePSEditions = @('Desktop', 'Core')
    GUID = 'fdafe383-4764-4663-9c53-ec0f30678a6d'
    Author = 'Derek Lomax'
    Copyright = '(c) 2025 Derek Lomax. All rights reserved.'
    Description = 'NPM provider for AnyPackage.'
    PowerShellVersion = '7.2'
    RequiredModules = @(
        @{ ModuleName = 'AnyPackage'; ModuleVersion = '0.9.0' }
    )
    FunctionsToExport = @()
    CmdletsToExport = @()
    AliasesToExport = @()
    PrivateData = @{
        AnyPackage = @{
            Providers = 'Npm'
        }
        PSData = @{
            Tags = @('AnyPackage', 'Provider', 'Windows')
            # LicenseUri = 'https://github.com/anypackage/modulefast/blob/main/LICENSE'
            # ProjectUri = 'https://github.com/anypackage/modulefast'
        }
    }
    # HelpInfoURI = 'https://go.anypackage.dev/help'
}
