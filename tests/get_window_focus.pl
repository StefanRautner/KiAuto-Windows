#!/usr/bin/perl
use strict;
use warnings;
use Time::HiRes qw(sleep);

# Detect OS
my $is_windows = ($^O =~ /win32/i);

if ($is_windows) {
    require Win32::GuiTest;
    Win32::GuiTest->import(qw(GetForegroundWindow));
}

while (1) {
    if ($is_windows) {
        # Get the active window handle on Windows
        my $hwnd = GetForegroundWindow();
        print "Active Window Handle: $hwnd\n";
    } else {
        # Linux: Use xdotool to get the focused window ID
        system("xdotool getwindowfocus");
    }

    sleep(1);
}
