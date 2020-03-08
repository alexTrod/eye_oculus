import json
from bidict import bidict

"""
Supported protocol:

GET
    Request : (same for both range and switch features)
        {
            "feature" : feature_name
        }
        -> 0000c (where c is the command character)             
    Response :
        Range :
            xxxxc (where xxxx is the requested value) ->
            {
                "featureType" : "range",
                feature_name : {
                    "value" : value,
                }
            }
        Switch :
            000xc (where x is either T or F) ->
            {
                "featureType" : "switch",
                feature_name : {
                    "on" : boolean,
                }
            }
    The GET functionality is currently not supported for dropdown features

POST
    Request :
        Range :
            {
                "featureType" : "range",
                feature_name : {
                    "value" : value,
                }
            } -> xxxxc (where xxxx is the value to be posted)
        Switch :
            {
                "featureType" : "switch",
                feature_name : {
                    "on" : boolean,
                }
            } -> 000xc (where x is either T or F)
        Dropdown:
            {
                "featureType" : "dropdown",
                feature_name : {
                    "value" : option,
                }
            } -> 0000c
    Response :
        Range :
            xxxxc ->
            {
                "featureType" : "range",
                feature_name : {
                    "value" : value,
                }
            }
        Switch :
            000xc ->
            {
                "featureType" : "switch",
                feature_name : {
                    "on" : boolean,
                }
            }
        Dropdown:
            0000c ->
            {
                "featureType" : "dropdown",
                feature_name : {
                    "value" : option,
                }
            }
"""

dictionary = bidict({
    "A": "heating mode.fan oven",
    "B": "heating mode.conventional",
    "C": "heating mode.bottom element",
    "D": "heating mode.fan and grill",
    "E": "heating mode.grill",
    "F": "oven light",
    "G": "heating mode.defrosting",
    "H": "get temperature",
    "I": "set temperature",
    "J": "timer"
})


def json_to_cmd(data):
    data = json.loads(data)
    feature_name, value = "", 0
    feature_type = None

    if "featureType" in data:  # POST request
        feature_type = data["featureType"]

        json_keys = list(data.keys())
        json_keys.remove("featureType")
        feature_name = json_keys[0]  # doesn't work with the current format for drop down menus

        if feature_type == "range" or feature_type == "dropdown":
            value = data[feature_name]["value"]
        elif feature_type == "switch":
            value = data[feature_name]["on"]

    elif "feature" in data:  # GET request
        feature_name = data["feature"]

    cmd_arg = str(value)
    request = feature_name

    if feature_type == "dropdown":
        request += "." + value
        cmd_arg = ""

    elif feature_type == "switch":
        cmd_arg = "T" if value else "F"

    if request not in dictionary.inverse or len(cmd_arg) > 4:
        print("unable to translate", data, "to cmds")
        return b''

    cmd_char = dictionary.inverse[request]
    cmd_arg = "0" * (4 - len(cmd_arg)) + cmd_arg

    print("translated", data, "to", bytes(cmd_arg + cmd_char, 'utf-8'))
    return bytes(cmd_arg + cmd_char, 'utf-8')


def cmd_to_json(cmd):
    cmd = cmd.decode('utf-8')
    cmd_arg, cmd_char = cmd[:4], cmd[4]

    if cmd_char in dictionary:
        trans = dictionary[cmd_char].split(".")
        feature_name = trans[0]

        if len(trans) > 1:
            json_data = {"featureType": "dropdown",
                         feature_name: {
                             "value": trans[1]
                         }}

        elif "T" in cmd_arg or "F" in cmd_arg:
            json_data = {"featureType": "switch",
                         feature_name: {
                             "on": "T" in cmd_arg
                         }}

        else:
            json_data = {"featureType": "range",
                         feature_name: {
                             "value": int(cmd_arg)
                         }}

    else:
        print("unable to translate", cmd, "to json")
        return b''

    print("translated", cmd, "to", bytes(json.dumps(json_data), 'utf-8'))
    return bytes(json.dumps(json_data), 'utf-8')
