#Requires -Modules AnyPackage.ModuleFast

Describe Install-Package {
    BeforeEach {
        New-Item -Path $env:LOCALAPPDATA\powershell\Modules -ItemType Directory
        Remove-Item -Path "$env:LOCALAPPDATA\powershell\Modules\*" -Recurse
    }

    Context 'with -Name parameter' {
        It 'should install' {
            { Install-Package -Name Az -Verbose -Debug } |
            Should -Not -Throw
        }
    }
}
