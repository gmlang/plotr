cb_color = function(name) {
        black = "#000000"
        gray = grey = "#999999"
        orange = "#E69F00"
        sky_blue = "#56B4E9"
        bluish_green = "#009E73"
        yellow = "#F0E442"
        blue = "#0072B2"
        vermilion = "#D55E00"
        reddish_purple = "#CC79A7"
        cb = c(orange, sky_blue, bluish_green, yellow, blue, vermilion, 
               reddish_purple)
        cb_pair = c(blue, vermilion)
        cb_pair2 = c(blue, reddish_purple)
        cb_pair3 = c(sky_blue, vermilion)
        cb_pair4 = c(sky_blue, reddish_purple)
        cb_pair5 = c(bluish_green, vermilion)
        cb_pair6 = c(bluish_green, reddish_purple)
        switch(name, 
               black = black, gray = gray, grey = grey, orange = orange,
               sky_blue = sky_blue, bluish_green = bluish_green, 
               yellow = yellow, blue = blue, vermilion = vermilion,
               reddish_purple = reddish_purple, cb_gray = c(gray, cb), 
               cb_grey = c(grey, cb), cb_black = c(black, cb),
               cb_pair = cb_pair, cb_pair2 = cb_pair2, cb_pair3 = cb_pair3, 
               cb_pair4 = cb_pair4, cb_pair5 = cb_pair5, cb_pair6 = cb_pair6)
}
