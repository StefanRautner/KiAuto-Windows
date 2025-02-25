#!/usr/bin/perl
use strict;
use warnings;
use Time::HiRes qw(sleep);

# Detect OS
my $is_windows = ($^O =~ /win32/i);

if ($is_windows) {
    require Win32::GuiTest;
    Win32::GuiTest->import(qw(FindWindowLike GetForegroundWindow GetWindowText));
}

while (1) {
    my $a;

    if ($is_windows) {
        # Get active window title on Windows
        my $hwnd = GetForegroundWindow();
        $a = GetWindowText($hwnd);
    } else {
        # Get active window title on Linux using xdotool
        $a = `xdotool getwindowfocus getwindowname`;
    }

    print "$a\n----\n";

    if ($is_windows) {
        # Find PCBnew window on Windows
        my @windows = FindWindowLike(0, "Pcbnew.*");
        foreach my $hwnd (@windows) {
            print GetWindowText($hwnd) . "\n";
        }
    } else {
        # Find PCBnew window on Linux using xdotool
        $a = `xdotool search --onlyvisible --name 'Pcbnew.*'`;
        print $a;
    }

    sleep(1);
}
