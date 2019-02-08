----------------------------------------------------------------------------------------------
---IMPORTS
----------------------------------------------------------------------------------------------
    -- Base
import XMonad
import XMonad.Config.Desktop
import Data.Maybe (isJust)
import System.IO (hPutStrLn)
import System.Exit (exitSuccess)
import qualified XMonad.StackSet as W

    -- Utilities
import XMonad.Util.Loggers
import XMonad.Util.EZConfig (additionalKeysP, additionalMouseBindings)
import XMonad.Util.NamedScratchpad (NamedScratchpad(NS), namedScratchpadManageHook, namedScratchpadAction, customFloating)
import XMonad.Util.Run (safeSpawn, unsafeSpawn, runInTerm, spawnPipe)
import XMonad.Util.SpawnOnce

    -- Hooks
import XMonad.Hooks.DynamicLog (dynamicLogWithPP, defaultPP, wrap, pad, xmobarPP, xmobarColor, shorten, PP(..))
import XMonad.Hooks.ManageDocks (avoidStruts, docksStartupHook, manageDocks, ToggleStruts(..))
import XMonad.Hooks.ManageHelpers (isFullscreen, isDialog,  doFullFloat, doCenterFloat)
import XMonad.Hooks.Place (placeHook, withGaps, smart)
import XMonad.Hooks.InsertPosition
import XMonad.Hooks.FloatNext (floatNextHook, toggleFloatNext, toggleFloatAllNew)
import XMonad.Hooks.SetWMName
import XMonad.Hooks.EwmhDesktops   -- required for xcomposite in obs to work

    -- Actions
import XMonad.Actions.Promote
import XMonad.Actions.RotSlaves (rotSlavesDown, rotAllDown)
import XMonad.Actions.CopyWindow (kill1, copyToAll, killAllOtherCopies, runOrCopy)
import XMonad.Actions.WindowGo (runOrRaise, raiseMaybe)
import XMonad.Actions.WithAll (sinkAll, killAll)
import XMonad.Actions.CycleWS (moveTo, shiftTo, WSType(..), shiftNextScreen, shiftPrevScreen)
import XMonad.Actions.GridSelect (GSConfig(..), goToSelected, bringSelected, colorRangeFromClassName, buildDefaultGSConfig)
import XMonad.Actions.DynamicWorkspaces (addWorkspacePrompt, removeEmptyWorkspace)
import XMonad.Actions.Warp (warpToWindow, banishScreen, Corner(LowerRight))
import XMonad.Actions.MouseResize
import qualified XMonad.Actions.ConstrainedResize as Sqr

    -- Layouts modifiers
import XMonad.Layout.PerWorkspace (onWorkspace)
import XMonad.Layout.Renamed (renamed, Rename(CutWordsLeft, Replace))
import XMonad.Layout.WorkspaceDir
import XMonad.Layout.Spacing (spacing)
import XMonad.Layout.Minimize
import XMonad.Layout.Maximize
import XMonad.Layout.NoBorders
import XMonad.Layout.BoringWindows (boringWindows)
import XMonad.Layout.LimitWindows (limitWindows, increaseLimit, decreaseLimit)
import XMonad.Layout.WindowArranger (windowArrange, WindowArrangerMsg(..))
import XMonad.Layout.Reflect (reflectVert, reflectHoriz, REFLECTX(..), REFLECTY(..))
import XMonad.Layout.MultiToggle (mkToggle, single, EOT(EOT), Toggle(..), (??))
import XMonad.Layout.MultiToggle.Instances (StdTransformers(NBFULL, MIRROR, NOBORDERS))
import qualified XMonad.Layout.ToggleLayouts as T (toggleLayouts, ToggleLayout(Toggle))

    -- Layouts
import XMonad.Layout.GridVariants (Grid(Grid))
import XMonad.Layout.SimplestFloat
import XMonad.Layout.OneBig
import XMonad.Layout.ThreeColumns
import XMonad.Layout.ResizableTile
import XMonad.Layout.ZoomRow (zoomRow, zoomIn, zoomOut, zoomReset, ZoomMessage(ZoomFullToggle))
import XMonad.Layout.IM (withIM, Property(Role))

    -- Prompts
import XMonad.Prompt (defaultXPConfig, XPConfig(..), XPPosition(Top), Direction1D(..))

----------------------------------------------------------------------------------------------
---CONFIG
----------------------------------------------------------------------------------------------
myModMask       = mod4Mask  -- Sets modkey to super/windows key
myTerminal      = "termite" -- Sets default terminal
myTextEditor    = "emacs"   -- Sets default text editor
myBorderWidth   = 3         -- Sets border width for windows
windowCount 	= gets $ Just . show . length . W.integrate' . W.stack . W.workspace . W.current . windowset

main = do
    xmproc0 <- spawnPipe "xmobar ~/.xmonad/xmobar.hs"  -- Launches xmobar
    xmonad $ ewmh desktopConfig
        { manageHook = ( isFullscreen --> doFullFloat ) <+> manageHook defaultConfig <+> manageDocks
        , logHook = dynamicLogWithPP xmobarPP
                    { ppOutput = \x -> hPutStrLn xmproc0 x
                    , ppCurrent = xmobarColor "#8e508a" "" . wrap "[" "]"  -- Current workspace in xmobar
                    , ppVisible = xmobarColor "#8e508a" "" . wrap "" ""    -- Visible but not current workspace
                    , ppHidden = xmobarColor "#D33682" ""                  -- Hidden workspaces in xmobar
                    , ppHiddenNoWindows = xmobarColor "#D33682" ""         -- Hidden workspaces (no windows)
                    , ppTitle = xmobarColor "#859900" "" . shorten 80      -- Title of active window in xmobar
                    , ppSep =  "<fc=#839496> : </fc>"                      -- Separators in xmobar
                    , ppUrgent = xmobarColor "#C45500" "" . wrap "!" "!"   -- Urgent workspace
                    , ppExtras  = [windowCount]                            -- # of windows current workspace
                    , ppOrder  = \(ws:l:t:exs) -> [ws,l]++exs++[t]
                    }
        , modMask            = myModMask
        , terminal           = myTerminal
        , startupHook        = myStartupHook
        , layoutHook         = myLayoutHook
        , workspaces         = myWorkspaces
        , borderWidth        = myBorderWidth
        , normalBorderColor  = "#5f5286"
        , focusedBorderColor = "#453b61"
        } `additionalKeysP` myKeys

----------------------------------------------------------------------------------------------
---AUTOSTART
----------------------------------------------------------------------------------------------
myStartupHook = do
          spawnOnce "termite &"
          spawnOnce "nitrogen --restore &"
          spawnOnce "compton --backend=glx --config /home/k175un3/.config/compton/compton.conf &"
          setWMName "XMonad"

----------------------------------------------------------------------------------------------
---KEYBINDINGS
----------------------------------------------------------------------------------------------
myKeys =
    -- Xmonad
        [ ("M-C-r",             spawn "xmonad --recompile")      -- Recompiles xmonad
        , ("M-S-r",             spawn "xmonad --restart")        -- Restarts xmonad
        , ("M-S-q",             io exitSuccess)                  -- Quits xmonad

    -- Windows
        , ("M-r",               refresh)                         -- Refresh
        , ("M-S-c",             kill1)                           -- Kill the currently focused client
        , ("M-S-a",             killAll)                         -- Kill all the windows on the current workspace

        , ("M-<Delete>",        withFocused $ windows . W.sink)
        , ("M-S-<Delete>",      sinkAll)                         -- Pushes all floating windows on current workspace back into tiling
        , ("M-m",               windows W.focusMaster)           -- Move focus to the master window
        , ("M-j",               windows W.focusDown)             -- Move focus to the next window
        , ("M-k",               windows W.focusUp)               -- Move focus to the prev window
        , ("M-S-m",             windows W.swapMaster)            -- Swap the focused window and the master window
        , ("M-S-j",             windows W.swapDown)              -- Swap the focused window with the next window
        , ("M-S-k",             windows W.swapUp)                -- Swap the focused window with the prev window
        , ("M-<Backspace>",     promote)                         -- Moves focused window to master window. All others maintain order
        , ("M1-S-<Tab>",        rotSlavesDown)                   -- Rotate all windows except the master and keep the focus in place
        , ("M1-C-<Tab>",        rotAllDown)                      -- Rotate all the windows in the current stack

        , ("M-*",               withFocused minimizeWindow)
        , ("M-S-*",             sendMessage RestoreNextMinimizedWin)
        , ("M-!",               withFocused (sendMessage . maximizeRestore))
        , ("M-$",               toggleFloatNext)
        , ("M-S-$",             toggleFloatAllNew)
        , ("M-S-s",             windows copyToAll)
        , ("M-C-s",             killAllOtherCopies)

        , ("M-C-M1-<Up>",       sendMessage Arrange)
        , ("M-C-M1-<Down>",     sendMessage DeArrange)
        , ("M-<Up>",            sendMessage (MoveUp 10))         --  Move focused window to up
        , ("M-<Down>",          sendMessage (MoveDown 10))       --  Move focused window to down
        , ("M-<Right>",         sendMessage (MoveRight 10))      --  Move focused window to right
        , ("M-<Left>",          sendMessage (MoveLeft 10))       --  Move focused window to left
        , ("M-S-<Up>",          sendMessage (IncreaseUp 10))     --  Increase size of focused window up
        , ("M-S-<Down>",        sendMessage (IncreaseDown 10))   --  Increase size of focused window down
        , ("M-S-<Right>",       sendMessage (IncreaseRight 10))  --  Increase size of focused window right
        , ("M-S-<Left>",        sendMessage (IncreaseLeft 10))   --  Increase size of focused window left
        , ("M-C-<Up>",          sendMessage (DecreaseUp 10))     --  Decrease size of focused window up
        , ("M-C-<Down>",        sendMessage (DecreaseDown 10))   --  Decrease size of focused window down
        , ("M-C-<Right>",       sendMessage (DecreaseRight 10))  --  Decrease size of focused window right
        , ("M-C-<Left>",        sendMessage (DecreaseLeft 10))   --  Decrease size of focused window left

    -- Layouts
        , ("M-S-<Space>",       sendMessage ToggleStruts)
        , ("M-d",               asks (XMonad.layoutHook . config) >>= setLayout)
        , ("M-<KP_Enter>",      sendMessage NextLayout)
        , ("M-S-f",             sendMessage (T.Toggle "floatz"))
        , ("M-S-g",             sendMessage (T.Toggle "gimp"))
        , ("M-S-x",             sendMessage $ Toggle REFLECTX)
        , ("M-S-y",             sendMessage $ Toggle REFLECTY)
        , ("M-S-m",             sendMessage $ Toggle MIRROR)
        , ("M-S-b",             sendMessage $ Toggle NOBORDERS)
        , ("M-S-d",             sendMessage (Toggle NBFULL) >> sendMessage ToggleStruts)
        , ("M-<KP_Multiply>",   sendMessage (IncMasterN 1))      -- Increase the number of clients in the master pane
        , ("M-<KP_Divide>",     sendMessage (IncMasterN (-1)))   -- Decrease the number of clients in the master pane
        , ("M-S-<KP_Multiply>", increaseLimit)                   -- Increase the number of windows that can be shown
        , ("M-S-<KP_Divide>",   decreaseLimit)                   -- Decrease the number of windows that can be shown

        , ("M-h",               sendMessage Shrink)
        , ("M-l",               sendMessage Expand)
        , ("M-S-;",             sendMessage zoomReset)
        , ("M-;",               sendMessage ZoomFullToggle)

    -- Workspaces
        , ("M-<KP_Add>",        moveTo Next nonNSP)                         -- Go to next workspace
        , ("M-<KP_Subtract>",   moveTo Prev nonNSP)                         -- Go to previous workspace
        , ("M-S-<KP_Add>",      shiftTo Next nonNSP >> moveTo Next nonNSP)  -- Shifts focused window to next workspace
        , ("M-S-<KP_Subtract>", shiftTo Prev nonNSP >> moveTo Prev nonNSP)  -- Shifts focused window to previous workspace


    -- Main Run Apps
        , ("M-<Return>",        spawn myTerminal)

    -- GUI Apps
        , ("M-w",               spawn "firefox")
        , ("M-e",               runOrRaise "emacs" (resource =? "emacs"))

    -- Multimedia Keys
        -- , ("<XF86AudioMute>",   spawn "amixer set Master toggle")  -- Bug prevents it from toggling correctly in 12.04.
        , ("<XF86AudioLowerVolume>", spawn "amixer set Master 5%- unmute")
        , ("<XF86AudioRaiseVolume>", spawn "amixer set Master 5%+ unmute")
        , ("<Print>",           spawn "scrotd 0")
        ] where nonNSP          = WSIs (return (\ws -> W.tag ws /= "NSP"))
                nonEmptyNonNSP  = WSIs (return (\ws -> isJust (W.stack ws) && W.tag ws /= "NSP"))


----------------------------------------------------------------------------------------------
---WORKSPACES
----------------------------------------------------------------------------------------------

xmobarEscape = concatMap doubleLts
  where
        doubleLts '<' = "<<"
        doubleLts x   = [x]

myWorkspaces :: [String]
myWorkspaces = clickable . (map xmobarEscape)
               $ ["一", "二", "三", "四", "五"]
  where
        clickable l = [ "<action=xdotool key super+" ++ show (n) ++ ">" ++ ws ++ "</action>" |
                      (i,ws) <- zip [1..5] l,
                      let n = i ]

myManageHook = placeHook (withGaps (20,12,12,12) (smart (0.5,0.5))) <+> insertPosition End Newer <+> floatNextHook <+>
        (composeAll . concat $
        [ [ resource  =? r --> doF (W.view "一" . W.shift "一")   | r <- myTermApps    ]
        , [ resource  =? r --> doF (W.view "三" . W.shift "三")   | r <- myWebApps     ]
        , [ resource  =? r --> doF (W.view "四" . W.shift "四")   | r <- myMediaApps   ]
        , [ resource  =? r --> doF (W.view "五" . W.shift "五")   | r <- mySystApps    ]
        , [ resource  =? r --> doFloat                            | r <- myFloatApps   ]
        ]) <+> manageHook defaultConfig
        where
            myTermApps    = ["termite", "termite", "htop", "irssi"]
            myWebApps     = ["firefox", "thunderbird"]
            myMediaApps   = ["vlc", "ncmpcpp", "gimp"]
            mySystApps    = ["mc", "nitrogen"]
            myFloatApps   = ["zoom", "nitrogen"]


----------------------------------------------------------------------------------------------
---LAYOUTS
----------------------------------------------------------------------------------------------
myLayoutHook = avoidStruts $ mouseResize $ windowArrange $ T.toggleLayouts floatz $
               mkToggle (NBFULL ?? NOBORDERS ?? EOT) $ renamed [CutWordsLeft 4] $ maximize $
               minimize $ boringWindows $ spacing 0 $
               mySysLayout $
               myDevLayout $
               myWebLayout $
               myChatLayout $
               myDefaultLayout

myDefaultLayout = grid ||| threeCol ||| threeRow ||| oneBig ||| noBorders monocle ||| space ||| floatz
myDevLayout = onWorkspace (myWorkspaces !! 1) $ noBorders monocle ||| grid ||| oneBig ||| floatz
myWebLayout = onWorkspace (myWorkspaces !! 2) $ noBorders monocle ||| oneBig ||| threeCol ||| threeRow ||| grid
myChatLayout = onWorkspace (myWorkspaces !! 3) $ grid  ||| threeCol ||| threeRow ||| oneBig ||| floatz
mySysLayout = onWorkspace (myWorkspaces !! 4) $ oneBig ||| threeCol ||| threeRow ||| grid

grid            = renamed [Replace "グリッド"] $ limitWindows 12 $ spacing 4 $ mkToggle (single MIRROR) $ Grid (16/10)
threeCol        = renamed [Replace "三桁"] $ limitWindows 3 $ ThreeCol 1 (3/100) (1/2)
threeRow        = renamed [Replace "三行"] $ limitWindows 3 $ Mirror $ mkToggle (single MIRROR) zoomRow
oneBig          = renamed [Replace "一大きい"] $ limitWindows 6 $ Mirror $ mkToggle (single MIRROR) $ mkToggle (single REFLECTX) $ mkToggle (single REFLECTY) $ OneBig (5/9) (8/12)
monocle         = renamed [Replace "単眼"] $ limitWindows 20 Full
space           = renamed [Replace "空間"] $ limitWindows 4 $ spacing 36 $ Mirror $ mkToggle (single MIRROR) $ mkToggle (single REFLECTX) $ mkToggle (single REFLECTY) $ OneBig (2/3) (2/3)
floatz          = renamed [Replace "浮く"] $ limitWindows 20 simplestFloat
