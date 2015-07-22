# TODO

- [ ] Better template selection
- [X] Alias (for function and maybe parameters)
- [X] Package as Module
- [ ] Pester test cases?
- [ ] Dynamic parameters/parameter sets based on template selection?
- [X] Ability to change sound
- [ ] Action when clicking toast
- [ ] Bundle a function to restore default PowerShell start screen/menu shortcut(s)
- [ ] Fill out comment based help
- [X] Nicer validation script output (break out to function which throws)
- [ ] Refactor
    - [ ] Parameter Names?
    - [ ] Pipeline input?
    - [X] Maintain line length of 120
	- [ ] Variable names make sense?
	- [ ] Any redundant code?
	- [ ] Switch statement best way of taking care of text
- [X] AppId as Parameter (user can pass it in)
- [X] Default AppId gathered at run time using Get-StartApps
- [ ] Add silent switch (toast makes no sound)
- [ ] Don't try adding an image if a template with no image is selected

## Meta

- [ ] Write better install instructions for README.md
- [ ] Write install.ps1 script and chocolatey style Invoke-Expression install instructions
- [ ] Write build script for compiling new .zip archives for point releases.
    - [ ] Possibly also automate the creation of a new release on GitHub (and downgrade previous release from 'latest')
