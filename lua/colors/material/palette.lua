local M = {}

--- @class ColorDefinition
--- @field gui string The GUI and termguicolors hex value of the color
--- @field cterm number|"NONE" The cterm color index of the color

--- @alias ColorGradient { [number|string]: ColorDefinition }

--- @alias Palette { [string]: ColorGradient, transparent: ColorDefinition }

--- @type Palette
M.palette = {
  red = {
    [50] = { gui = "#ffebee", cterm = 255 },
    [100] = { gui = "#ffcdd2", cterm = 224 },
    [200] = { gui = "#ef9a9a", cterm = 210 },
    [300] = { gui = "#e57373", cterm = 174 },
    [400] = { gui = "#ef5350", cterm = 203 },
    [500] = { gui = "#f44336", cterm = 203 },
    [600] = { gui = "#e53935", cterm = 167 },
    [700] = { gui = "#d32f2f", cterm = 160 },
    [800] = { gui = "#c62828", cterm = 160 },
    [900] = { gui = "#b71c1c", cterm = 124 },
    A100 = { gui = "#ff8a80", cterm = 210 },
    A200 = { gui = "#ff5252", cterm = 203 },
    A400 = { gui = "#ff1744", cterm = 197 },
    A700 = { gui = "#d50000", cterm = 160 },
  },
  pink = {
    [50] = { gui = "#fce4ec", cterm = 255 },
    [100] = { gui = "#f8bbd0", cterm = 218 },
    [200] = { gui = "#f48fb1", cterm = 211 },
    [300] = { gui = "#f06292", cterm = 204 },
    [400] = { gui = "#ec407a", cterm = 204 },
    [500] = { gui = "#e91e63", cterm = 161 },
    [600] = { gui = "#d81b60", cterm = 161 },
    [700] = { gui = "#c2185b", cterm = 125 },
    [800] = { gui = "#ad1457", cterm = 125 },
    [900] = { gui = "#880e4f", cterm = 89 },
    A100 = { gui = "#ff80ab", cterm = 211 },
    A200 = { gui = "#ff4081", cterm = 204 },
    A400 = { gui = "#f50057", cterm = 197 },
    A700 = { gui = "#c51162", cterm = 161 },
  },
  purple = {
    [50] = { gui = "#f3e5f5", cterm = 255 },
    [100] = { gui = "#e1bee7", cterm = 182 },
    [200] = { gui = "#ce93d8", cterm = 176 },
    [300] = { gui = "#ba68c8", cterm = 134 },
    [400] = { gui = "#ab47bc", cterm = 133 },
    [500] = { gui = "#9c27b0", cterm = 127 },
    [600] = { gui = "#8e24aa", cterm = 91 },
    [700] = { gui = "#7b1fa2", cterm = 91 },
    [800] = { gui = "#6a1b9a", cterm = 54 },
    [900] = { gui = "#4a148c", cterm = 54 },
    A100 = { gui = "#ea80fc", cterm = 177 },
    A200 = { gui = "#e040fb", cterm = 171 },
    A400 = { gui = "#d500f9", cterm = 165 },
    A700 = { gui = "#aa00ff", cterm = 129 },
  },
  deep_purple = {
    [50] = { gui = "#ede7f6", cterm = 255 },
    [100] = { gui = "#d1c4e9", cterm = 188 },
    [200] = { gui = "#b39ddb", cterm = 146 },
    [300] = { gui = "#9575cd", cterm = 104 },
    [400] = { gui = "#7e57c2", cterm = 97 },
    [500] = { gui = "#673ab7", cterm = 61 },
    [600] = { gui = "#5e35b1", cterm = 61 },
    [700] = { gui = "#512da8", cterm = 55 },
    [800] = { gui = "#4527a0", cterm = 55 },
    [900] = { gui = "#311b92", cterm = 54 },
    A100 = { gui = "#b388ff", cterm = 141 },
    A200 = { gui = "#7c4dff", cterm = 99 },
    A400 = { gui = "#651fff", cterm = 57 },
    A700 = { gui = "#6200ea", cterm = 56 },
  },
  indigo = {
    [50] = { gui = "#e8eaf6", cterm = 255 },
    [100] = { gui = "#c5cae9", cterm = 252 },
    [200] = { gui = "#9fa8da", cterm = 146 },
    [300] = { gui = "#7986cb", cterm = 104 },
    [400] = { gui = "#5c6bc0", cterm = 61 },
    [500] = { gui = "#3f51b5", cterm = 61 },
    [600] = { gui = "#3949ab", cterm = 61 },
    [700] = { gui = "#303f9f", cterm = 61 },
    [800] = { gui = "#283593", cterm = 24 },
    [900] = { gui = "#1a237e", cterm = 18 },
    A100 = { gui = "#8c9eff", cterm = 111 },
    A200 = { gui = "#536dfe", cterm = 63 },
    A400 = { gui = "#3d5afe", cterm = 63 },
    A700 = { gui = "#304ffe", cterm = 63 },
  },
  blue = {
    [50] = { gui = "#e3f2fd", cterm = 195 },
    [100] = { gui = "#bbdefb", cterm = 153 },
    [200] = { gui = "#90caf9", cterm = 117 },
    [300] = { gui = "#64b5f6", cterm = 75 },
    [400] = { gui = "#42a5f5", cterm = 75 },
    [500] = { gui = "#2196f3", cterm = 33 },
    [600] = { gui = "#1e88e5", cterm = 32 },
    [700] = { gui = "#1976d2", cterm = 32 },
    [800] = { gui = "#1565c0", cterm = 25 },
    [900] = { gui = "#0d47a1", cterm = 25 },
    A100 = { gui = "#82b1ff", cterm = 111 },
    A200 = { gui = "#448aff", cterm = 69 },
    A400 = { gui = "#2979ff", cterm = 33 },
    A700 = { gui = "#2962ff", cterm = 27 },
  },
  light_blue = {
    [50] = { gui = "#e1f5fe", cterm = 195 },
    [100] = { gui = "#b3e5fc", cterm = 153 },
    [200] = { gui = "#81d4fa", cterm = 117 },
    [300] = { gui = "#4fc3f7", cterm = 81 },
    [400] = { gui = "#29b6f6", cterm = 39 },
    [500] = { gui = "#03a9f4", cterm = 39 },
    [600] = { gui = "#039be5", cterm = 38 },
    [700] = { gui = "#0288d1", cterm = 32 },
    [800] = { gui = "#0277bd", cterm = 31 },
    [900] = { gui = "#01579b", cterm = 25 },
    A100 = { gui = "#80d8ff", cterm = 117 },
    A200 = { gui = "#40c4ff", cterm = 81 },
    A400 = { gui = "#00b0ff", cterm = 39 },
    A700 = { gui = "#0091ea", cterm = 32 },
  },
  cyan = {
    [50] = { gui = "#e0f7fa", cterm = 195 },
    [100] = { gui = "#b2ebf2", cterm = 159 },
    [200] = { gui = "#80deea", cterm = 116 },
    [300] = { gui = "#4dd0e1", cterm = 80 },
    [400] = { gui = "#26c6da", cterm = 44 },
    [500] = { gui = "#00bcd4", cterm = 38 },
    [600] = { gui = "#00acc1", cterm = 37 },
    [700] = { gui = "#0097a7", cterm = 31 },
    [800] = { gui = "#00838f", cterm = 30 },
    [900] = { gui = "#006064", cterm = 23 },
    A100 = { gui = "#84ffff", cterm = 123 },
    A200 = { gui = "#18ffff", cterm = 51 },
    A400 = { gui = "#00e5ff", cterm = 45 },
    A700 = { gui = "#00b8d4", cterm = 38 },
  },
  teal = {
    [50] = { gui = "#e0f2f1", cterm = 255 },
    [100] = { gui = "#b2dfdb", cterm = 152 },
    [200] = { gui = "#80cbc4", cterm = 116 },
    [300] = { gui = "#4db6ac", cterm = 73 },
    [400] = { gui = "#26a69a", cterm = 36 },
    [500] = { gui = "#009688", cterm = 30 },
    [600] = { gui = "#00897b", cterm = 30 },
    [700] = { gui = "#00796b", cterm = 29 },
    [800] = { gui = "#00695c", cterm = 23 },
    [900] = { gui = "#004d40", cterm = 23 },
    A100 = { gui = "#a7ffeb", cterm = 159 },
    A200 = { gui = "#64ffda", cterm = 86 },
    A400 = { gui = "#1de9b6", cterm = 43 },
    A700 = { gui = "#00bfa5", cterm = 37 },
  },
  green = {
    [50] = { gui = "#e8f5e9", cterm = 255 },
    [100] = { gui = "#c8e6c9", cterm = 252 },
    [200] = { gui = "#a5d6a7", cterm = 151 },
    [300] = { gui = "#81c784", cterm = 114 },
    [400] = { gui = "#66bb6a", cterm = 71 },
    [500] = { gui = "#4caf50", cterm = 71 },
    [600] = { gui = "#43a047", cterm = 71 },
    [700] = { gui = "#388e3c", cterm = 65 },
    [800] = { gui = "#2e7d32", cterm = 239 },
    [900] = { gui = "#1b5e20", cterm = 22 },
    A100 = { gui = "#b9f6ca", cterm = 158 },
    A200 = { gui = "#69f0ae", cterm = 85 },
    A400 = { gui = "#00e676", cterm = 42 },
    A700 = { gui = "#00c853", cterm = 41 },
  },
  light_green = {
    [50] = { gui = "#f1f8e9", cterm = 255 },
    [100] = { gui = "#dcedc8", cterm = 194 },
    [200] = { gui = "#c5e1a5", cterm = 187 },
    [300] = { gui = "#aed581", cterm = 150 },
    [400] = { gui = "#9ccc65", cterm = 149 },
    [500] = { gui = "#8bc34a", cterm = 113 },
    [600] = { gui = "#7cb342", cterm = 107 },
    [700] = { gui = "#689f38", cterm = 71 },
    [800] = { gui = "#558b2f", cterm = 64 },
    [900] = { gui = "#33691e", cterm = 58 },
    A100 = { gui = "#ccff90", cterm = 192 },
    A200 = { gui = "#b2ff59", cterm = 155 },
    A400 = { gui = "#76ff03", cterm = 118 },
    A700 = { gui = "#64dd17", cterm = 76 },
  },
  lime = {
    [50] = { gui = "#f9fbe7", cterm = 230 },
    [100] = { gui = "#f0f4c3", cterm = 230 },
    [200] = { gui = "#e6ee9c", cterm = 193 },
    [300] = { gui = "#dce775", cterm = 186 },
    [400] = { gui = "#d4e157", cterm = 185 },
    [500] = { gui = "#cddc39", cterm = 185 },
    [600] = { gui = "#c0ca33", cterm = 149 },
    [700] = { gui = "#afb42b", cterm = 142 },
    [800] = { gui = "#9e9d24", cterm = 142 },
    [900] = { gui = "#827717", cterm = 100 },
    A100 = { gui = "#f4ff81", cterm = 228 },
    A200 = { gui = "#eeff41", cterm = 227 },
    A400 = { gui = "#c6ff00", cterm = 190 },
    A700 = { gui = "#aeea00", cterm = 148 },
  },
  yellow = {
    [50] = { gui = "#fffde7", cterm = 230 },
    [100] = { gui = "#fff9c4", cterm = 230 },
    [200] = { gui = "#fff59d", cterm = 229 },
    [300] = { gui = "#fff176", cterm = 228 },
    [400] = { gui = "#ffee58", cterm = 227 },
    [500] = { gui = "#ffeb3b", cterm = 227 },
    [600] = { gui = "#fdd835", cterm = 221 },
    [700] = { gui = "#fbc02d", cterm = 214 },
    [800] = { gui = "#f9a825", cterm = 214 },
    [900] = { gui = "#f57f17", cterm = 208 },
    A100 = { gui = "#ffff8d", cterm = 228 },
    A200 = { gui = "#ffff00", cterm = 226 },
    A400 = { gui = "#ffea00", cterm = 220 },
    A700 = { gui = "#ffd600", cterm = 220 },
  },
  amber = {
    [50] = { gui = "#fff8e1", cterm = 230 },
    [100] = { gui = "#ffecb3", cterm = 229 },
    [200] = { gui = "#ffe082", cterm = 222 },
    [300] = { gui = "#ffd54f", cterm = 221 },
    [400] = { gui = "#ffca28", cterm = 220 },
    [500] = { gui = "#ffc107", cterm = 214 },
    [600] = { gui = "#ffb300", cterm = 214 },
    [700] = { gui = "#ffa000", cterm = 214 },
    [800] = { gui = "#ff8f00", cterm = 208 },
    [900] = { gui = "#ff6f00", cterm = 202 },
    A100 = { gui = "#ffe57f", cterm = 222 },
    A200 = { gui = "#ffd740", cterm = 221 },
    A400 = { gui = "#ffc400", cterm = 220 },
    A700 = { gui = "#ffab00", cterm = 214 },
  },
  orange = {
    [50] = { gui = "#fff3e0", cterm = 230 },
    [100] = { gui = "#ffe0b2", cterm = 223 },
    [200] = { gui = "#ffcc80", cterm = 222 },
    [300] = { gui = "#ffb74d", cterm = 215 },
    [400] = { gui = "#ffa726", cterm = 214 },
    [500] = { gui = "#ff9800", cterm = 208 },
    [600] = { gui = "#fb8c00", cterm = 208 },
    [700] = { gui = "#f57c00", cterm = 208 },
    [800] = { gui = "#ef6c00", cterm = 202 },
    [900] = { gui = "#e65100", cterm = 166 },
    A100 = { gui = "#ffd180", cterm = 222 },
    A200 = { gui = "#ffab40", cterm = 215 },
    A400 = { gui = "#ff9100", cterm = 208 },
    A700 = { gui = "#ff6d00", cterm = 202 },
  },
  deep_orange = {
    [50] = { gui = "#fbe9e7", cterm = 255 },
    [100] = { gui = "#ffccbc", cterm = 223 },
    [200] = { gui = "#ffab91", cterm = 216 },
    [300] = { gui = "#ff8a65", cterm = 209 },
    [400] = { gui = "#ff7043", cterm = 203 },
    [500] = { gui = "#ff5722", cterm = 202 },
    [600] = { gui = "#f4511e", cterm = 202 },
    [700] = { gui = "#e64a19", cterm = 166 },
    [800] = { gui = "#d84315", cterm = 166 },
    [900] = { gui = "#bf360c", cterm = 130 },
    A100 = { gui = "#ff9e80", cterm = 216 },
    A200 = { gui = "#ff6e40", cterm = 203 },
    A400 = { gui = "#ff3d00", cterm = 202 },
    A700 = { gui = "#dd2c00", cterm = 160 },
  },
  brown = {
    [50] = { gui = "#efebe9", cterm = 255 },
    [100] = { gui = "#d7ccc8", cterm = 252 },
    [200] = { gui = "#bcaaa4", cterm = 145 },
    [300] = { gui = "#a1887f", cterm = 138 },
    [400] = { gui = "#8d6e63", cterm = 95 },
    [500] = { gui = "#795548", cterm = 95 },
    [600] = { gui = "#6d4c41", cterm = 240 },
    [700] = { gui = "#5d4037", cterm = 238 },
    [800] = { gui = "#4e342e", cterm = 237 },
    [900] = { gui = "#3e2723", cterm = 236 },
  },
  grey = {
    [50] = { gui = "#fafafa", cterm = 231 },
    [100] = { gui = "#f5f5f5", cterm = 255 },
    [200] = { gui = "#eeeeee", cterm = 255 },
    [300] = { gui = "#e0e0e0", cterm = 254 },
    [400] = { gui = "#bdbdbd", cterm = 250 },
    [500] = { gui = "#9e9e9e", cterm = 247 },
    [600] = { gui = "#757575", cterm = 243 },
    [700] = { gui = "#616161", cterm = 241 },
    [800] = { gui = "#424242", cterm = 238 },
    [900] = { gui = "#212121", cterm = 235 },
  },
  blue_grey = {
    [50] = { gui = "#eceff1", cterm = 255 },
    [100] = { gui = "#cfd8dc", cterm = 188 },
    [200] = { gui = "#b0bec5", cterm = 250 },
    [300] = { gui = "#90a4ae", cterm = 109 },
    [400] = { gui = "#78909c", cterm = 103 },
    [500] = { gui = "#607d8b", cterm = 66 },
    [600] = { gui = "#546e7a", cterm = 60 },
    [700] = { gui = "#455a64", cterm = 240 },
    [800] = { gui = "#37474f", cterm = 238 },
    [900] = { gui = "#263238", cterm = 236 },
  },
  transparent = { gui = "NONE", cterm = "NONE" },
}

return M