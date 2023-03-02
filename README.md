# Speech2Text Audio Transcription/Translation Script

This PowerShell script can transcribe or translate an audio file using the OpenAI API. The output is saved to a file. 

## Usage

Before using the script, make sure you have an OpenAI API key and have set the environment variable OPENAI_API_KEY to the API key. 

To use the script, run the following command:

.\voice2word.ps1 -FilePath "<path/to/audio/file>" [-Type "<transcriptions/translations>"]

Replace `<path/to/audio/file>` with the path to the audio file you want to transcribe/translate. 

By default, the script will generate a transcription of the audio file. If you want to generate a translation instead, use the `-Type` parameter and set it to "translations".

## Parameters

- `FilePath` (required): The path to the audio file. 

- `Type` (optional): The type of output to generate. Valid values are "transcriptions" (default) and "translations".

## Examples

To transcribe an audio file:

.\voice2word.ps1 -FilePath "C:\audio.wav"

This command transcribes the audio file "audio.wav" and saves the transcription to a file named "result.txt".

To translate an audio file:

.\Transcribe-Audio.ps1 -FilePath "C:\audio.wav" -Type "translations"

This command translates the audio file "audio.wav" and saves the translation to a file named "result.txt".
