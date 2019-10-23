import re
from xkeysnail.transform import *

define_modmap({
    Key.CAPSLOCK, Key.LEFT_CTRL
})

define_multipurpose_modmap({
    Key.LEFT_META: [Key.MUHENKAN, Key.LEFT_META],
    Key.RIGHT_META: [Key.HENKAN, Key.RIGHT_META]
})
