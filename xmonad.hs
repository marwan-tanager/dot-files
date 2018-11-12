import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Util.EZConfig
import System.IO
import XMonad.Layout.NoBorders
import qualified XMonad.StackSet as W
import Control.Monad (liftM2)
import XMonad.Config.Gnome
import XMonad.Util.Dmenu

myManageHook = composeAll
    [ className =? "XClock" 		 --> doFloat
    , className =? "Vlc" 		 --> viewShift "3"
    , className =? "Google-chrome" 	 --> viewShift "2"
    , className =? "Firefox" 		 --> viewShift "2"
    , className =? "VirtualBox" 	 --> viewShift "9"
    , className =? "Ncmpcpp" 		 --> viewShift "3"
    , className =? "Mutt" 		 --> viewShift "5"
    , className =? "Zathura" 		 --> viewShift "4"
    , className =? "Audacious" 		 --> viewShift "3"
    , className =? "mplayer2" 		 --> viewShift "3"
    , className =? "mpv" 		 --> viewShift "3"
    , className =? "Tor Browser" 	 --> viewShift "2"
    , className =? "MuPDF" 		 --> viewShift "4"
    ]
    where viewShift = doF . liftM2 (.) W.greedyView W.shift 

main = xmonad $ gnomeConfig
        { terminal = "x-terminal-emulator"
	, manageHook = manageDocks <+> myManageHook <+> manageHook defaultConfig
        , layoutHook = avoidStruts $ smartBorders $ layoutHook defaultConfig
        } `additionalKeys`
	  [ ((mod1Mask, xK_w), spawn "dmenu_run -i -l 10 -nf 'Green' -nb black -sb 'Green' -sf black -nb black -fn Mono-10")
	  , ((mod1Mask, xK_a), spawn "toggle-xclock")
	  , ((mod1Mask, xK_e), spawn "scrot -u -e 'cp $f ~/ss.png; mv $f ~/;' ~/'ss_%s_$wx$h.png'")
	  , ((mod1Mask, xK_n), spawn "/home/marwan/bin/stf")
	  ]
	`removeKeysP` ["M-p"]
	`removeKeysP` ["M-b"]
