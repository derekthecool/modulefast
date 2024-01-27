#Requires -Modules AnyPackage.ModuleFast

Describe Install-Package {
    AfterEach {
        Remove-Item -Path "$env:LOCALAPPDATA\powershell\Modules\*" -Recurse
    }

    Context 'with -Name parameter' {
        It 'should install' {
            { Install-Package -Name Az } |
            Should -Not -Throw
        }
    }
}
