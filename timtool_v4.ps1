# STA FIX
if ([Threading.Thread]::CurrentThread.ApartmentState -ne 'STA') {
    Start-Process powershell.exe -ArgumentList "-STA -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -WindowStyle Normal
    exit
}

$ErrorActionPreference = 'Stop'
Add-Type -AssemblyName PresentationFramework

# GUI (XAML)
$xaml = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        Title="Tim Tool"
        Height="750"
        Width="600"
        WindowStartupLocation="CenterScreen">

    <ScrollViewer VerticalScrollBarVisibility="Auto">
    <StackPanel Margin="10">

    <StackPanel Margin="0,10">
    <!-- Text steht oben -->
    <TextBlock Text="Windows Settings" FontWeight="Bold" FontSize="14" 
               HorizontalAlignment="Center"/>
    
    <!-- Linie unter dem Text -->
    <Separator Height="2" Background="Gray" Margin="0,3,0,0"/>
</StackPanel>

        <!-- Reihe 1 -->
        <Grid Margin="0,0,0,8">
            <Grid.ColumnDefinitions>
                <ColumnDefinition Width="*"/>
                <ColumnDefinition Width="*"/>
            </Grid.ColumnDefinitions>

            <Button Grid.Column="0" Name="BtnRegistryRunGlobal" Height="35" Margin="5">
                Globale start apps (Regedit)
            </Button>
            <TextBlock Grid.Column="1" Text="(?!!!)" FontWeight="Bold" FontSize="14"
                       VerticalAlignment="Center" HorizontalAlignment="Center" Cursor="Help">
                <TextBlock.ToolTip>
                    <ToolTip MaxWidth="300">
                        <TextBlock TextWrapping="Wrap"
                                   Text="ACHTUNG BEIM SPIELEN MIT DER REGESTRY regestry. regestry buttons kopieren den pfad des eintrages in die zwischenablage!!" />
                    </ToolTip>
                </TextBlock.ToolTip>
            </TextBlock>
        </Grid>

        <!-- Reihe 2 -->
        <Grid Margin="0,0,0,8">
            <Grid.ColumnDefinitions>
                <ColumnDefinition Width="*"/>
                <ColumnDefinition Width="*"/>
            </Grid.ColumnDefinitions>

            <Button Grid.Column="0" Name="BtnRegistryRunLocal" Height="35" Margin="5">
                Benutzer start apps (Regedit)
            </Button>
            <Button Grid.Column="1" Name="BtnTaskManager" Height="35" Margin="5">
                Taskmanager
            </Button>
        </Grid>

        <!-- Reihe 3 -->
        <Grid Margin="0,0,0,8">
            <Grid.ColumnDefinitions>
                <ColumnDefinition Width="*"/>
                <ColumnDefinition Width="*"/>
            </Grid.ColumnDefinitions>

            <Button Grid.Column="0" Name="BtnNetworkConnections" Height="35" Margin="5">
                Netzwerkverbindungen
            </Button>
            <Button Grid.Column="1" Name="BtnMSInfo" Height="35" Margin="5">
                Systeminformationen
            </Button>
        </Grid>

        <!-- Reihe 4 -->
        <Grid Margin="0,0,0,8">
            <Grid.ColumnDefinitions>
                <ColumnDefinition Width="*"/>
                <ColumnDefinition Width="*"/>
            </Grid.ColumnDefinitions>

            <Button Grid.Column="0" Name="BtnGeraetemngr" Height="35" Margin="5">
                Geraetemanager
            </Button>
            <Button Grid.Column="1" Name="BtnFestplatten" Height="35" Margin="5">
                Festplattenverwaltung
            </Button>
        </Grid>

        <!-- Reihe 5 -->
        <Grid Margin="0,0,0,8">
            <Grid.ColumnDefinitions>
                <ColumnDefinition Width="*"/>
                <ColumnDefinition Width="*"/>
            </Grid.ColumnDefinitions>

            <Button Grid.Column="0" Name="BtnMaus" Height="35" Margin="5">
                Erweiterte Mauseinstellungen
            </Button>
            <Button Grid.Column="1" Name="BtnSound" Height="35" Margin="5">
                Erweiterte Soundeinstellungen
            </Button>
        </Grid>

        <StackPanel>
    <!-- Text steht oben -->
    <TextBlock Text="GitHub stuff" FontWeight="Bold" FontSize="14" 
               HorizontalAlignment="Center"/>
    
    <!-- Linie unter dem Text -->
    <Separator Height="2" Background="Gray" Margin="0,3,0,0"/>
</StackPanel>

        <!-- Reihe 6 -->
        <Grid Margin="0,0,0,8">
            <Grid.ColumnDefinitions>
                <ColumnDefinition Width="*"/>
                <ColumnDefinition Width="*"/>
            </Grid.ColumnDefinitions>

            <Button Grid.Column="0" Name="BtnCTT" Height="35" Margin="5">
                CTT winutil (Github)
            </Button>
            <Button Grid.Column="1" Name="BtnRemoveWindowsAI" Height="35" Margin="5">
                RemoveWindowsAI (Github)
            </Button>
        </Grid>

<StackPanel Margin="0,10">
    <!-- Text steht oben -->
    <TextBlock Text="youtube vids" FontWeight="Bold" FontSize="14" 
               HorizontalAlignment="Center"/>
    
    <!-- Linie unter dem Text -->
    <Separator Height="2" Background="Gray" Margin="0,3,0,0"/>
</StackPanel>

        <!-- Reihe 7 -->
        <Grid Margin="0,0,0,8">
            <Grid.ColumnDefinitions>
                <ColumnDefinition Width="*"/>
                <ColumnDefinition Width="*"/>
            </Grid.ColumnDefinitions>

            <Button Grid.Column="0" Name="BtnPcOptimasationGuide" Height="35" Margin="5">
                PC-Optimierungsleitfaden (Youtube)
            </Button>
            <Button Grid.Column="1" Name="BtnBiosTweaks" Height="35" Margin="5">
                Bios Tweaks Benchmarks (AMD)(Youtube)
            </Button>
        </Grid>

        <!-- Letzter Button alleine (ungerade Anzahl) -->
        <Grid Margin="0,0,0,8">
            <Grid.ColumnDefinitions>
                <ColumnDefinition Width="*"/>
            </Grid.ColumnDefinitions>

            <Button Grid.Column="0" Name="BtnPlaceholder" Height="35" Margin="5">
                Programm XYZ
            </Button>
        </Grid>

    </StackPanel>
    </ScrollViewer>
</Window>
"@

# WINDOW LADEN
try {
    $reader = New-Object System.Xml.XmlNodeReader ([xml]$xaml)
    $window = [Windows.Markup.XamlReader]::Load($reader)
}
catch {
    [System.Windows.MessageBox]::Show($_.Exception.Message, "XAML Fehler")
    exit
}

# BUTTONS
$BtnRegistryRunGlobal   = $window.FindName("BtnRegistryRunGlobal")
$BtnRegistryRunLocal    = $window.FindName("BtnRegistryRunLocal")
$BtnTaskManager         = $window.FindName("BtnTaskManager")
$BtnNetworkConnections  = $window.FindName("BtnNetworkConnections")
$BtnMSInfo              = $window.FindName("BtnMSInfo")
$BtnGeraetemngr         = $window.FindName("BtnGeraetemngr")
$BtnFestplatten         = $window.FindName("BtnFestplatten")
$BtnMaus                = $window.FindName("BtnMaus")
$BtnSound               = $window.FindName("BtnSound")
$BtnCTT                 = $window.FindName("BtnCTT")
$BtnRemoveWindowsAI     = $window.FindName("BtnRemoveWindowsAI")
$BtnPcOptimasationGuide = $window.FindName("BtnPcOptimasationGuide")
$BtnBiosTweaks          = $window.FindName("BtnBiosTweaks")
$BtnPlaceholder         = $window.FindName("BtnPlaceholder")

# LOGIK
$BtnRegistryRunGlobal.Add_Click({
    Start-Process regedit.exe
    Start-Sleep -Milliseconds 300
    Set-Clipboard "Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run"
})

$BtnRegistryRunLocal.Add_Click({
    Start-Process regedit.exe
    Start-Sleep -Milliseconds 300
    Set-Clipboard "Computer\HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run"
})

$BtnTaskManager.Add_Click({ Start-Process taskmgr })
$BtnNetworkConnections.Add_Click({ Start-Process ncpa.cpl })
$BtnMSInfo.Add_Click({ Start-Process msinfo32.exe })
$BtnGeraetemngr.Add_Click({ Start-Process devmgmt.msc })
$BtnFestplatten.Add_Click({ Start-Process diskmgmt.msc })
$BtnMaus.Add_Click({ Start-Process main.cpl })
$BtnSound.Add_Click({ Start-Process mmsys.cpl })
$BtnCTT.Add_Click({ Start-Process "https://github.com/ChrisTitusTech/winutil" })
$BtnRemoveWindowsAI.Add_Click({ Start-Process "https://github.com/zoicware/RemoveWindowsAI"})
$BtnPcOptimasationGuide.Add_Click({ Start-Process "https://www.youtube.com/watch?v=2Tel-p60B1g"})
$BtnBiosTweaks.Add_Click({ Start-Process "https://www.youtube.com/watch?v=Vp332dU5xOU"})
$BtnPlaceholder.Add_Click({ Start-Process notepad.exe })

# START – BLOCKIERT, BLEIBT OFFEN

$null = $window.ShowDialog()


