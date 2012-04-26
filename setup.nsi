; Script generated with the Venis Install Wizard

; Define your application name
!define APPNAME "PuttyWrap"
!define APPNAMEANDVERSION "PuttyWrap"

; Main Install settings
Name "${APPNAMEANDVERSION}"
InstallDir "$PROGRAMFILES\PuttyWrap"
InstallDirRegKey HKLM "Software\${APPNAME}" ""
OutFile "PuttyWrap-setup_v1.0.3.exe"

LicenseData "License.txt"
LicenseText "If you accept the terms of the agreement, click I Agree to continue. You must accept the agreement to install ${APPNAMEANDVERSION}."

DirText "Choose the folder in which to install ${APPNAMEANDVERSION}."

Section "PuttyWrap"

	; Set Section properties
	SetOverwrite on

	; Set Section Files and Shortcuts
	SetOutPath "$INSTDIR\"
	File "bin\Release\PuttyWrap.exe"
	File "bin\Release\System.Data.SQLite.DLL"
	File "bin\Release\WeifenLuo.WinFormsUI.Docking.dll"
	CreateShortCut "$DESKTOP\PuttyWrap.lnk" "$INSTDIR\PuttyWrap.exe"
	CreateDirectory "$SMPROGRAMS\PuttyWrap"
	CreateShortCut "$SMPROGRAMS\PuttyWrap\PuttyWrap.lnk" "$INSTDIR\PuttyWrap.exe"
	CreateShortCut "$SMPROGRAMS\PuttyWrap\Uninstall.lnk" "$INSTDIR\uninstall.exe"

SectionEnd

Section -FinishSection

	WriteRegStr HKLM "Software\${APPNAME}" "" "$INSTDIR"
	WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APPNAME}" "DisplayName" "${APPNAME}"
	WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APPNAME}" "UninstallString" "$INSTDIR\uninstall.exe"
	WriteUninstaller "$INSTDIR\uninstall.exe"

	MessageBox MB_YESNO "Would you like to run ${APPNAMEANDVERSION}?" IDNO NoRun
		Exec "$INSTDIR\PuttyWrap.exe"
	NoRun:

SectionEnd

;Uninstall section
Section Uninstall

	;Remove from registry...
	DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APPNAME}"
	DeleteRegKey HKLM "SOFTWARE\${APPNAME}"

	; Delete self
	Delete "$INSTDIR\uninstall.exe"

	; Delete Shortcuts
	Delete "$DESKTOP\PuttyWrap.lnk"
	Delete "$SMPROGRAMS\PuttyWrap\PuttyWrap.lnk"
	Delete "$SMPROGRAMS\PuttyWrap\Uninstall.lnk"

	; Clean up PuttyWrap
	Delete "$INSTDIR\PuttyWrap.exe"
	Delete "$INSTDIR\System.Data.SQLite.DLL"
	Delete "$INSTDIR\WeifenLuo.WinFormsUI.Docking.dll"

	; Remove remaining directories
	RMDir "$SMPROGRAMS\PuttyWrap"
	RMDir "$INSTDIR\"

SectionEnd

Function un.onInit

	MessageBox MB_YESNO|MB_DEFBUTTON2|MB_ICONQUESTION "Remove ${APPNAMEANDVERSION} and all of its components?" IDYES DoUninstall
		Abort
	DoUninstall:

FunctionEnd

; eof