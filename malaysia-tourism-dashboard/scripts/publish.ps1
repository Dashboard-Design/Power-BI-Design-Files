<parameter name="content"># ===================================================================
# POWER BI PUBLISH AUTOMATION SCRIPT
# ===================================================================
# Description: Publishes the Malaysia Tourism Dashboard to Power BI Service
# Prerequisites:
#   1. Install module: Install-Module -Name MicrosoftPowerBIMgmt -Scope CurrentUser
#   2. Power BI Pro or Premium Per User license
#   3. Workspace permissions (Admin or Member)
# Usage: .\publish.ps1
# ===================================================================

[CmdletBinding()]
param(
    [Parameter(Mandatory=$false)]
    [string]$WorkspaceName = "Malaysia Open Data Demo",

    [Parameter(Mandatory=$false)]
    [string]$DatasetName = "Malaysia Tourism Arrivals",

    [Parameter(Mandatory=$false)]
    [string]$PBIXFilePath = "",

    [Parameter(Mandatory=$false)]
    [switch]$CreateWorkspaceIfNotExists = $true,

    [Parameter(Mandatory=$false)]
    [switch]$TriggerRefresh = $true,

    [Parameter(Mandatory=$false)]
    [switch]$OverwriteExisting = $true
)

# Error handling
$ErrorActionPreference = "Stop"

# Function to write colored output
function Write-ColorOutput {
    param(
        [string]$Message,
        [string]$Color = "White"
    )
    Write-Host $Message -ForegroundColor $Color
}

# Banner
Write-ColorOutput "`n===================================================" "Cyan"
Write-ColorOutput " POWER BI PUBLISH AUTOMATION" "Cyan"
Write-ColorOutput " Malaysia Tourism Dashboard" "Cyan"
Write-ColorOutput "===================================================`n" "Cyan"

# Step 1: Check if module is installed
Write-ColorOutput "[1/8] Checking PowerShell module..." "Yellow"
if (-not (Get-Module -ListAvailable -Name MicrosoftPowerBIMgmt)) {
    Write-ColorOutput "ERROR: MicrosoftPowerBIMgmt module not found!" "Red"
    Write-ColorOutput "Install with: Install-Module -Name MicrosoftPowerBIMgmt -Scope CurrentUser" "Red"
    exit 1
}
Write-ColorOutput "      Module found!" "Green"

# Step 2: Login to Power BI Service
Write-ColorOutput "`n[2/8] Authenticating to Power BI Service..." "Yellow"
try {
    Connect-PowerBIServiceAccount -WarningAction SilentlyContinue | Out-Null
    Write-ColorOutput "      Authentication successful!" "Green"
} catch {
    Write-ColorOutput "ERROR: Authentication failed!" "Red"
    Write-ColorOutput $_.Exception.Message "Red"
    exit 1
}

# Step 3: Find or create workspace
Write-ColorOutput "`n[3/8] Looking for workspace: $WorkspaceName..." "Yellow"
$workspace = Get-PowerBIWorkspace -Name $WorkspaceName -ErrorAction SilentlyContinue

if ($null -eq $workspace) {
    if ($CreateWorkspaceIfNotExists) {
        Write-ColorOutput "      Workspace not found. Creating..." "Yellow"
        try {
            $workspace = New-PowerBIWorkspace -Name $WorkspaceName
            Write-ColorOutput "      Workspace created: $($workspace.Id)" "Green"
        } catch {
            Write-ColorOutput "ERROR: Failed to create workspace!" "Red"
            Write-ColorOutput $_.Exception.Message "Red"
            exit 1
        }
    } else {
        Write-ColorOutput "ERROR: Workspace not found and auto-creation disabled!" "Red"
        exit 1
    }
} else {
    Write-ColorOutput "      Workspace found: $($workspace.Id)" "Green"
}

# Step 4: Locate PBIX file
Write-ColorOutput "`n[4/8] Locating PBIX file..." "Yellow"
if ([string]::IsNullOrWhiteSpace($PBIXFilePath)) {
    # Auto-detect PBIX in project directory
    $scriptPath = Split-Path -Parent $MyInvocation.MyCommand.Path
    $projectRoot = Split-Path -Parent $scriptPath
    $pbixFiles = Get-ChildItem -Path $projectRoot -Filter "*.pbix" -Recurse

    if ($pbixFiles.Count -eq 0) {
        Write-ColorOutput "ERROR: No PBIX file found in project directory!" "Red"
        Write-ColorOutput "Please specify -PBIXFilePath parameter or create a PBIX file" "Red"
        Write-ColorOutput "`nNote: This script works with PBIX files. If using PBIP, please:" "Yellow"
        Write-ColorOutput "  1. Open the .pbip project in Power BI Desktop" "Yellow"
        Write-ColorOutput "  2. Save as .pbix file" "Yellow"
        Write-ColorOutput "  3. Re-run this script" "Yellow"
        exit 1
    } elseif ($pbixFiles.Count -gt 1) {
        Write-ColorOutput "Multiple PBIX files found:" "Yellow"
        $pbixFiles | ForEach-Object { Write-ColorOutput "  - $($_.FullName)" "White" }
        $PBIXFilePath = $pbixFiles[0].FullName
        Write-ColorOutput "Using: $PBIXFilePath" "Green"
    } else {
        $PBIXFilePath = $pbixFiles[0].FullName
        Write-ColorOutput "      Found: $PBIXFilePath" "Green"
    }
} else {
    if (-not (Test-Path $PBIXFilePath)) {
        Write-ColorOutput "ERROR: PBIX file not found at: $PBIXFilePath" "Red"
        exit 1
    }
    Write-ColorOutput "      Using: $PBIXFilePath" "Green"
}

# Step 5: Check if dataset already exists
Write-ColorOutput "`n[5/8] Checking for existing dataset..." "Yellow"
$existingDataset = Get-PowerBIDataset -WorkspaceId $workspace.Id | Where-Object { $_.Name -eq $DatasetName }

if ($existingDataset -and -not $OverwriteExisting) {
    Write-ColorOutput "ERROR: Dataset already exists and overwrite is disabled!" "Red"
    Write-ColorOutput "Use -OverwriteExisting flag to overwrite" "Yellow"
    exit 1
} elseif ($existingDataset) {
    Write-ColorOutput "      Existing dataset found. Will overwrite." "Yellow"
}

# Step 6: Publish PBIX file
Write-ColorOutput "`n[6/8] Publishing PBIX to Power BI Service..." "Yellow"
try {
    $importResult = New-PowerBIReport -Path $PBIXFilePath `
                                      -WorkspaceId $workspace.Id `
                                      -ConflictAction CreateOrOverwrite `
                                      -ErrorAction Stop

    Write-ColorOutput "      Report published successfully!" "Green"
    Write-ColorOutput "      Report ID: $($importResult.Id)" "Green"
} catch {
    Write-ColorOutput "ERROR: Failed to publish report!" "Red"
    Write-ColorOutput $_.Exception.Message "Red"
    exit 1
}

# Step 7: Update dataset parameters (if needed)
Write-ColorOutput "`n[7/8] Configuring dataset parameters..." "Yellow"
Write-ColorOutput "      Manual step required:" "Yellow"
Write-ColorOutput "      1. Go to workspace: $WorkspaceName" "Cyan"
Write-ColorOutput "      2. Open dataset settings for: $DatasetName" "Cyan"
Write-ColorOutput "      3. Update 'DataSourceMode' parameter to 'Web'" "Cyan"
Write-ColorOutput "      4. Update credentials for web data source if prompted" "Cyan"
Write-ColorOutput "      (This script cannot automate credential updates due to API limitations)" "Yellow"

# Step 8: Trigger dataset refresh (optional)
if ($TriggerRefresh) {
    Write-ColorOutput "`n[8/8] Triggering dataset refresh..." "Yellow"
    Write-ColorOutput "      Waiting 10 seconds for dataset to be ready..." "Yellow"
    Start-Sleep -Seconds 10

    try {
        # Get the dataset
        $dataset = Get-PowerBIDataset -WorkspaceId $workspace.Id | Where-Object { $_.Name -eq $DatasetName }

        if ($dataset) {
            # Trigger refresh using REST API
            $refreshUrl = "https://api.powerbi.com/v1.0/myorg/groups/$($workspace.Id)/datasets/$($dataset.Id)/refreshes"
            Invoke-PowerBIRestMethod -Url $refreshUrl -Method Post -Body "{}" | Out-Null
            Write-ColorOutput "      Refresh triggered!" "Green"
            Write-ColorOutput "      Note: Refresh may fail if data source credentials not configured" "Yellow"
        } else {
            Write-ColorOutput "      WARNING: Could not find dataset to refresh" "Yellow"
        }
    } catch {
        Write-ColorOutput "      WARNING: Failed to trigger refresh (this is normal if credentials not set)" "Yellow"
        Write-ColorOutput "      $($_.Exception.Message)" "Yellow"
    }
} else {
    Write-ColorOutput "`n[8/8] Skipping dataset refresh (use -TriggerRefresh to enable)" "Yellow"
}

# Summary
Write-ColorOutput "`n===================================================" "Cyan"
Write-ColorOutput " PUBLISH COMPLETE!" "Green"
Write-ColorOutput "===================================================`n" "Cyan"
Write-ColorOutput "Workspace: $WorkspaceName" "White"
Write-ColorOutput "Dataset:   $DatasetName" "White"
Write-ColorOutput "Report:    Malaysia Tourism Arrivals" "White"
Write-ColorOutput "`nNext steps:" "Yellow"
Write-ColorOutput "  1. Configure data source credentials in the workspace" "Cyan"
Write-ColorOutput "  2. Trigger a manual refresh to load data" "Cyan"
Write-ColorOutput "  3. Share the report with stakeholders" "Cyan"
Write-ColorOutput "`nWorkspace URL:" "Yellow"
Write-ColorOutput "https://app.powerbi.com/groups/$($workspace.Id)/list`n" "Cyan"

# Disconnect
Disconnect-PowerBIServiceAccount -WarningAction SilentlyContinue | Out-Null
