function SignFolder {
    param (
        $folder
    )
    $files = $(Get-ChildItem $folder)
    foreach ($i in $files) {
        Write-Output $i.FullName
        if ($(Test-Path $i -PathType Container)) {
            Sign-Folder $i.FullName
        } else {
            gpg --default-key "elf-elysia.noreply@classisland.tech" --detach-sign $i.FullName
        }
    }
}

SignFolder ./metadata

Copy-Item ./metadata ./out/classisland -Recurse -Force