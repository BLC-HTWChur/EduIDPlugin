//import {savedData} from 'DataContainer.js';
var savedData = "test";

var EduIDPlugin = {
     authorizeProtocols: function(protocols, successCallback, errorCallback){

        console.log("this code is runnning on : " + device.platform);
        if(device.platform == "iOS"){
            
            console.log("savedData : " + savedData);
        }
        /*
        var original = successCallback;
        successCallback = function(msg) {
            console.log("Callbacks arguments: " + msg);
            return original.apply(this, arguments);
        }; */
        //Calling parse first for Android after 
        if(device.platform == "Android"){
            var original = successCallback;
            successCallback = function(msg) {
                console.log("Calling Parse in android");
                
                EduIDPlugin.parse(null, function(){}, function(error){});
                return original(this, arguments);
            };
        }
        

        cordova.exec(
            successCallback, // success callback function
            errorCallback, // error callback function
            'EduIDPlugin', // Java Class
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
            'EduIDPlugin',
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
            'EduIDPlugin', // Java Class
            'serviceNames', // action name
            []
        );
     },

    getEndpointURL: function(serviceName, protocolName, successCallback){
        cordova.exec(
            successCallback, // success callback function
            null, // error callback function
            'EduIDPlugin', // Java Class
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
            'EduIDPlugin', // Java Class
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
            'EduIDPlugin', // Java Class
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
            'EduIDPlugin', // Java Class
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
            'EduIDPlugin', // Java Class
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
            'EduIDPlugin', // Java Class
            'clearAllServices', // action name
            []
        );
     },

     serialize: function(successCallback){
        cordova.exec(
            successCallback, // success callback function
            null, // error callback function
            'EduIDPlugin', // Java Class
            'serialize', // action name
            []
        );
     },

     parse: function(serviceSpec, successCallback, errorCallback){
        cordova.exec(
            successCallback, // success callback function
            errorCallback, // error callback function
            'EduIDPlugin', // Java Class
            'parse', // action name
            [{                  // args
                "serviceSpec": serviceSpec
            }]
        );
     }

}

module.exports = EduIDPlugin;