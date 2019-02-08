Config { font    = "xft:IPAGothic:style=Regular:pixelsize=13:minspace=True"
       , bgColor = "#002B36"
       , fgColor = "#839496"
       , position = Top
       , lowerOnStart = True
       , hideOnStart = False
       , allDesktops = True
       , persistent = True
       , commands = [ Run Date "%a %b %_d %Y %H:%M:%S" "date" 10
                    , Run UnsafeStdinReader
                    ]
       , sepChar = "%"
       , alignSep = "}{"
       , template = "%UnsafeStdinReader% }{ <fc=#91A0BD> <fc=#fdf6e3>%date%</fc> </fc> "
       }
