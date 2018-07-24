# EduID Plugin for Cordova
Cordova plugin to use NAIL layer of the EduID Native App

## Installation
```
cordova plugin add https://github.com/EduID-Mobile/NAIL-Cordova --nofetch
```

*Note :: for the iOS side*

Since the plugin itself depends on the NAIL-iOS framework, make sure to set the xCode Project correctly so the framework could be found inside the project.

Please check the the "Framework Search Paths" in Build Setting and insert the correct path of the framework
and also add the framework NAIL-iOS to the target's general setting under the section Embedded Binaries (Drag & Drop the framework to this section)

## Methods
### authorizeProtocols(protocols, success, error)

This method implements the protocol authorization.

The method expects a list of protocol names as the first parameter.

#### Example:

```javascript
var protocols = [
    "org.ietf.oauth2"
];
var success = function() { 
    alert("Success!"); 
};
var error = function(message) { 
    alert("Error! " + message); 
};
NAIL_Cordova.authorizeProtocols(protocols, success, error);
```

### getServiceToken(serviceName, success, error)

This method return an access token for a service.
#### Example:

```javascript
var protocols = [
    "org.ietf.oauth2"
];
var serviceName = "Wall-E";
var success = function(token) { 
    alert("Success!"); 
};
var error = function(message) { 
    alert("Error! " + message); 
};
NAIL_Cordova.getServiceToken(
	serviceName,
	protocols[0], 
	success, 
	error);
```

```javascript
Data returned:
{  
	"access_token":"YmRkMmE3YzktMmMyNy00Yjc0LTkyZjAtNzFiOGIyMmNiMTQ4LLqXizNNb9BYq30qpsrYFamTO57BGiuRn4nvgGyO2mxvpEFiZQ4jFl8jO1yQFkkiZ9L5uj8_kw0cg-r-7VA0DQ",
	"expires_in":3600,
	"token_type":"Bearer",
	"api_key":"93728cfe7ff2d26781135ec8708e2b6b"
}
```
