# the format for one element is [modifier, [option1, translation], [option2, translation], ...] in case it's a command
# with different options, and [modifier, translation] in case it's a command with a numerical argument

json_to_cmd_trans = {
    "heating mode": [["fan oven", "A"], ["conventional", "B"], ["bottom element", "C"], ["fan and grill", "D"],
                     ["defrosting", "G"]],
    "oven light": "F",
    "get temperature": "H",
    "set temperature": "I",
    "timer": "J"
}

cmd_to_json_trans = {
    "A": ["heating mode", "fan oven"],
    "B": ["heating mode", "conventional"],
    "C": ["heating mode", "bottom element"],
    "D": ["heating mode", "fan and grill"],
    "E": ["heating mode", "grill"],
    "F": ["oven light"],
    "G": ["heating mode", "defrosting"],
    "H": ["get temperature"],
    "I": ["set temperature"],
    "J": ["timer"]
}


def json_to_cmd(key, arg):
    int_arg = isinstance(arg, int)

    cmd_char = ""
    cmd_arg = arg if int_arg else 0

    if key in json_to_cmd_trans:
        trans = json_to_cmd_trans[key]
        if int_arg:
            cmd_char = trans

        else:
            for sub_cmd in trans:
                if arg == sub_cmd[0]:
                    cmd_char = sub_cmd[1]

    cmd_arg = str(cmd_arg)
    while len(cmd_arg) < 4:
        cmd_arg = "0" + cmd_arg

    if len(cmd_arg) > 4 or len(cmd_char) == 0:
        return ""

    return cmd_arg + cmd_char


def cmd_to_json(cmd):
    cmd_arg, cmd_char = cmd[:4], cmd[4]
    json_key, json_val = "", ""
    if cmd_char in cmd_to_json_trans:
        trans = cmd_to_json_trans[cmd_char]
        json_key = trans[0]
        if len(trans) > 0:
            json_val = trans[1]
        else:
            json_val = int(cmd_arg)

    return {json_key: json_val}
