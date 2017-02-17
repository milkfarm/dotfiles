#!/usr/bin/osascript

on openInSafari(_url)
  tell application "Safari"
    set URL of document 1 to _url
  end tell
end openInSafari

on run argv
  set _browser to item 1 of argv
  set _url to item 2 of argv
  if _browser = "safari" then
    openInSafari(_url)
  else
    set theDialogText to "Unknown browser value '" & _browser & "'."
    display dialog theDialogText buttons {"Cancel"} default button 1
  end if
end run
