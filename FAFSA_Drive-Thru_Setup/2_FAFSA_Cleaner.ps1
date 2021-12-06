# Clearing any file on the FAFSA profile
Remove-Item "C:\Users\FAFSA\Desktop\*" -Force -Confirm:$false -Recurse
Remove-Item "C:\Users\FAFSA\Downloads\*" -Force -Confirm:$false -Recurse
Remove-Item "C:\Users\FAFSA\Documents\*" -Force -Confirm:$false -Recurse -Filter *.*
Remove-Item "C:\Users\FAFSA\Pictures\*" -Force -Confirm:$false -Recurse 