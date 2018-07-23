//simple variable, that hold the json string data (for iOS persistency)
var savedData = null;

//Store the json string data inside the local storage
var store = function(jsonString) {
    alert("storage type : " + typeof(Storage));
    if (typeof(Storage) !== "undefined") {
        localStorage.setItem("jsonString", jsonString);
    }
};

//Load the json string data from the local storage
var load = function(){
    if(typeof(Storage) !== "undefined" ){
        savedData = localStorage.getItem("jsonString");
        //alert("saved Data : " + savedData);
    }
};

//Delete the json string data from the local storage
var reset = function(){
    if(typeof(Storage) !== "undefined" ) {
        localStorage.removeItem("jsonString");
        savedData = null;
    }
};

var NAIL_Cordova = {
     authorizeProtocols: function(protocols, successCallback, errorCallback){

        console.log("this code is runnning on : " + device.platform);
        if(device.platform == "iOS"){
            
            load();
            /*
            if (savedData) {
                alert("no need to authorize");
                cordova.exec(
                    successCallback, // success callback function
                    null, // error callback function
                    'NAIL_Cordova', // Java Class
                    'parse', // action name
                    [{                  // args
                        "serviceSpec": savedData
                    }]
                );
                return; 
            } else {
                alert("no saved data");
            }*/
            //console.log("savedData : " + savedData);

            var original = successCallback;
            successCallback = function(msg){
                
                //store(msg);
                return original(this, arguments);
            };
        } else if(device.platform == "Android"){  //Calling parse first for Android after
            var original = successCallback;
            successCallback = function(msg) {
                console.log("Calling Parse in android");
                
                NAIL_Cordova.parse(null, function(){}, function(error){});
                return original(this, arguments);
            };
        }
        

        cordova.exec(
            successCallback, // success callback function
            errorCallback, // error callback function
            'NAIL_Cordova', // Java Class
            'authorizeProtocols', // action name
            [{                  // args
                "protocols": protocols
            }]
        );
     },

     authorizeProtocols2: function(protocols, successCallback, errorCallback){
         cordova.exec(
            successCallback,
            errorCallback,
            'NAIL_Cordova',
            'authorizeProtocols2',
            [{
                "protocols": protocols
            }]
         );
     },

     serviceNames: function(successCallback){
        cordova.exec(
            successCallback, // success callback function
            null, // error callback function
            'NAIL_Cordova', // Java Class
            'serviceNames', // action name
            []
        );
     },

    getEndpointURL: function(serviceName, protocolName, successCallback){
        cordova.exec(
            successCallback, // success callback function
            null, // error callback function
            'NAIL_Cordova', // Java Class
            'getEndpointURL', // action name
            [{                  // args
                "serviceName": serviceName,
                "protocolName": protocolName
            }]
        );
     },

    getDisplayName: function(serviceName, successCallback){
        cordova.exec(
            successCallback, // success callback function
            null, // error callback function
            'NAIL_Cordova', // Java Class
            'getDisplayName', // action name
            [{                  // args
                "serviceName": serviceName
            }]
        );
     },

     getServiceToken: function(serviceName, protocolName, successCallback){

        console.log("this code is runnning on : " + device.platform);
        if(device.platform == "Android"){
            
            var original = successCallback;
            successCallback = function(msg) {
                //var jsonString = JSON.stringify(msg);
                var tmp = JSON.parse(msg);
                console.log(Object.keys(tmp));
                return original(tmp);
            };
        }

        cordova.exec(
            successCallback, // success callback function
            null, // error callback function
            'NAIL_Cordova', // Java Class
            'getServiceToken', // action name
            [{                  // args
                "serviceName": serviceName,
                "protocolName": protocolName
            }]
        );
     },

     getServiceUrl: function(serviceName, successCallback, errorCallback){
        cordova.exec(
            successCallback, // success callback function
            errorCallback, // error callback function
            'NAIL_Cordova', // Java Class
            'getServiceUrl', // action name
            [{                  // args
                "serviceName": serviceName
            }]
        );
     },

     removeService: function(serviceName, successCallback){
        cordova.exec(
            successCallback, // success callback function
            null, // error callback function
            'NAIL_Cordova', // Java Class
            'removeService', // action name
            [{                  // args
                "serviceName": serviceName
            }]
        );
     },

     clearAllServices: function(successCallback){
        cordova.exec(
            successCallback, // success callback function
            null, // error callback function
            'NAIL_Cordova', // Java Class
            'clearAllServices', // action name
            []
        );
     },

     serialize: function(successCallback){
        cordova.exec(
            successCallback, // success callback function
            null, // error callback function
            'NAIL_Cordova', // Java Class
            'serialize', // action name
            []
        );
     },

     parse: function(serviceSpec, successCallback, errorCallback){
        cordova.exec(
            successCallback, // success callback function
            errorCallback, // error callback function
            'NAIL_Cordova', // Java Class
            'parse', // action name
            [{                  // args
                "serviceSpec": serviceSpec
            }]
        );
     }

}

module.exports = NAIL_Cordova;