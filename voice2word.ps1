<#
.SYNOPSIS
Transcribe or translate an audio file using the OpenAI API.

.DESCRIPTION
This script transcribes or translates an audio file using the OpenAI API. The transcription or translation is saved to a file.

.PARAMETER FilePath
The path to the audio file.

.PARAMETER Type
The type of output to generate. Valid values are "transcriptions" (default) and "translations".

.EXAMPLE
.\Transcribe-Audio.ps1 -FilePath "C:\audio.wav"

This command transcribes the audio file "audio.wav" and saves the transcription to a file named "result.txt".

.EXAMPLE
.\Transcribe-Audio.ps1 -FilePath "C:\audio.wav" -Type "translations"

This command translates the audio file "audio.wav" and saves the translation to a file named "result.txt".

.NOTES
This script requires an OpenAI API key. Set the environment variable OPENAI_API_KEY to the API key before running the script.
#>

[CmdletBinding()]
param (
    [Parameter(Mandatory=$true)]
    [ValidateNotNullOrEmpty()]
    [string]$FilePath,

    [Parameter(Mandatory=$false)]
    [ValidateSet("transcriptions","translations")]
    [string]$Type = "transcriptions"
)

$apiKey = $env:OPENAI_API_KEY
if (-not $apiKey) {
    Write-Error "API key not found. Set the environment variable OPENAI_API_KEY to the API key."
    exit 1
}

if (-not (Test-Path $FilePath)) {
    Write-Error "File not found: $FilePath"
    exit 1
}

if ($Type -ne "transcriptions" -and $Type -ne "translations") {
    Write-Error "Type must be either 'transcriptions' or 'translations'"
    exit 1
}

$url = "https://api.openai.com/v1/audio/$Type"
$headers = @{
    Authorization = "Bearer $apiKey"
}
$model = "whisper-1"
$fields = @{
    file = Get-Item $FilePath
    model = $model
}

try {
    $response = Invoke-RestMethod -Uri $url -Method POST -Headers $headers -ContentType "multipart/form-data" -Form $fields
    $responseText = $response.text | Out-String
    $resultFilePath = Join-Path (Split-Path $FilePath) "result.txt"
    $responseText | Out-File -FilePath $resultFilePath -Encoding utf8
    Write-Host "Output saved to $resultFilePath"
}
catch {
    Write-Error "An error occurred: $_"
}