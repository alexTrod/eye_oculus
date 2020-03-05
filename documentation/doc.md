The two protocols can be extended to work with multiple appliances.

Protocol A :
Protocol used for the connection between the microcontroller and the API
| code  | feature  |
|---|---|
| A |   turn|  
| B  | light  |  
| C | temperature  |   
| D | timer |
| E | heating |


Protocol B : 

Protocol used for the connection between the API and the client-side application 

We use HTTP.

# Get
### Get the value of any feature
##### Request :

```javascript
{
    "feature" : feature_code
}
```

##### Response :
Range :
```javascript
{
    "featureType" : feature_type, // range | switch | dropdown
    feature_name : { // temperature | timer
        "value" : value,
        "lower_bound" : lower_bound_value,
        "upper_bound" : upper_bound_value
    }
}
```
Switch :
```javascript
{
    "featureType" : feature_type, // range | switch | dropdown
    feature_name : { // turn | light
        "on" : boolean, // 
    }
}
```
Dropdown:
```javascript
{
    "featureType" : feature_type, // range | switch | dropdown
    "list" : [
        "option1",
        "option2",
        "option3",
        "option4"
    ]
}
```

# POST
### Post the value of any feature

##### Request :

Range :
```javascript
{
    "featureType" : feature_type, // range | switch | dropdown
    feature_name : { // temperature | timer
        "value" : value,
    }
}
```

Switch :
```javascript
{
    "featureType" : feature_type, // range | switch | dropdown
    feature_name : { // turn | light
        "on" : boolean, // 
    }
}
```

Dropdown:
```javascript
{
    "featureType" : feature_type, // range | switch | dropdown
    "value" : option
}
```

##### Response :
Range :
```javascript
{
    "featureType" : feature_type, // range | switch | dropdown
    feature_name : { // temperature | timer
        "value" : value,
    }
}
```
Switch :
```javascript
{
    "featureType" : feature_type, // range | switch | dropdown
    feature_name : { // turn | light
        "on" : boolean, // 
    }
}
```

Dropdown:
```javascript
{
    "featureType" : feature_type, // range | switch | dropdown
    "value" : option
}
