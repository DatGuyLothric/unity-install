#!/bin/bash

# Inputs: platforms changeset version

# Constants
supported_platforms=('macOS' 'Windows' 'iOS' 'Android' 'Linux' 'WebGL' 'AppleTV')
unity_editor_link="http://download.unity3d.com/download_unity/$2/MacEditorInstaller/Unity.pkg"
unity_editor_installer='/Downloads/Unity.pkg'
unity_windows_link="https://download.unity3d.com/download_unity/$2/MacEditorTargetInstaller/UnitySetup-Windows-Mono-Support-for-Editor-$3.pkg"
unity_windows_installer='/Downloads/Unity-Windows.pkg'
unity_ios_link="https://download.unity3d.com/download_unity/$2/MacEditorTargetInstaller/UnitySetup-Linux-Support-for-Editor-$3.pkg"
unity_ios_installer='/Downloads/Unity-iOS.pkg'
unity_android_link="https://download.unity3d.com/download_unity/$2/MacEditorTargetInstaller/UnitySetup-iOS-Support-for-Editor-$3.pkg"
unity_android_installer='/Downloads/Unity-Android.pkg'
unity_linux_link="https://download.unity3d.com/download_unity/$2/MacEditorTargetInstaller/UnitySetup-Android-Support-for-Editor-$3.pkg"
unity_linux_installer='/Downloads/Unity-Linux.pkg'
unity_webgl_link="https://download.unity3d.com/download_unity/$2/MacEditorTargetInstaller/UnitySetup-WebGL-Support-for-Editor-$3.pkg"
unity_webgl_installer='/Downloads/Unity-WebGL.pkg'
unity_appletv_link="https://download.unity3d.com/download_unity/$2/MacEditorTargetInstaller/UnitySetup-AppleTV-Support-for-Editor-$3.pkg"
unity_appletv_installer='/Downloads/Unity-AppleTV.pkg'

# Check installs function
check_installs() {
  # Inputs: type link installer installer_check plarforms cache
  if [[ $5 != *"$1"* && $1 != *'Editor'* ]]; then
    return
  elif [[ -e "$4" ]]; then
    return
  else
    if [[ -e "$3" || $6 == 'true' ]]; then
      echo "Installer was found"
    else
      sudo curl -o $3 $2
    fi
    sudo installer -dumplog -package $3 -target /Applications
  fi
}

# Editor
check_installs 'Editor' "$unity_editor_link" "$unity_editor_installer" '/Applications/Unity/Unity.app' "$1" "$EDITOR_CACHE"

# Windows
check_installs 'Windows' "$unity_windows_link" "$unity_windows_installer" '/Applications/Unity/PlaybackEngines/WindowsStandaloneSupport' "$1" "$WINDOWS_CACHE"

# iOS
check_installs 'iOS' "$unity_ios_link" "$unity_ios_installer" '/Applications/Unity/PlaybackEngines/iOSSupport' "$1" "$IOS_CACHE"

# Android
check_installs 'Android' "$unity_android_link" "$unity_android_installer" '/Applications/Unity/PlaybackEngines/AndroidSupport' "$1" "$ANDROID_CACHE"

# Linux
check_installs 'Linux' "$unity_linux_link" "$unity_linux_installer" '/Applications/Unity/PlaybackEngines/LinuxStandaloneSupport' "$1" "$LINUX_CACHE"

# WebGL
check_installs 'WebGL' "$unity_webgl_link" "$unity_webgl_installer" '/Applications/Unity/PlaybackEngines/WebGLSupport' "$1" "$WEBGL_CACHE"

# AppleTV
check_installs 'AppleTV' "$unity_appletv_link" "$unity_appletv_installer" '/Applications/Unity/PlaybackEngines/AppleTVSupport' "$1" "$APPLETV_CACHE"
