# see: www.expatpaul.eu/2014/04/vim-in-powershell/
# basically write those two lines to create your profile:
#   new-item -path $profile -itemtype file -force
#   notepad $profile

set-alias vim "C:/Program Files (x86)/Vim/Vim74/./vim.exe"

# did once: Install-Module PSReadline
# see: https://github.com/lzybkr/PSReadLine
if ($host.Name -eq 'ConsoleHost')
{
	Import-Module PSReadline
	Set-PSReadlineOption -EditMode Emacs
}
