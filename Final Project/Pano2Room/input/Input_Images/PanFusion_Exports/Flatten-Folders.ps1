# Get the current working directory (the root folder)
$root = Get-Location

# Loop through each subfolder in the current directory
Get-ChildItem -Directory | ForEach-Object {
    $subfolder = $_
    $folderName = $subfolder.Name
    $fullPath = $subfolder.FullName

    # Find the PNG file and prompt.txt file
    $pngFile = Get-ChildItem -Path $fullPath -Filter *.png | Select-Object -First 1
    $txtFile = Get-ChildItem -Path $fullPath -Filter prompt.txt | Select-Object -First 1

    # If both files exist, proceed
    if ($pngFile -and $txtFile) {
        # Define new names
        $newPngPath = Join-Path -Path $root -ChildPath ("$folderName.png")
        $newTxtPath = Join-Path -Path $root -ChildPath ("$folderName.txt")

        # Move and rename files
        Move-Item -Path $pngFile.FullName -Destination $newPngPath
        Move-Item -Path $txtFile.FullName -Destination $newTxtPath

        # Remove the now-empty subfolder
        Remove-Item -Path $fullPath -Recurse -Force
    }
}