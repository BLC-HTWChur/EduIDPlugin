import UIKit
import MobileCoreServices
import NAIL_iOS

@objc(NAIL_Cordova) class NAIL_Cordova : CDVPlugin {
    
    var command : CDVInvokedUrlCommand?
    private static var nail: NativeAppIntegrationLayer?
    
    ///Main function which would be call to open the extension
    @objc(authorizeProtocols:)
    func authorizeProtocols(command: CDVInvokedUrlCommand){
        
        self.command = command
        print("Args : " , command.arguments)
        
        let arg = command.arguments.first as! [String : Any]
        let item = arg["protocols"] as! [String]
        
        NAILapi.authorizeProtocols(protocolList: item){
            let pluginItem = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: $0)
            self.commandDelegate.send(pluginItem, callbackId: command.callbackId)
        }
    }
    
    @objc(authorizeProtocols2:)
    func authorizeProtocols2(command: CDVInvokedUrlCommand){
        
        let singleton = false
        self.command = command
        print("Args : " , command.arguments)
        print("IN PLUGIN SWIFT , singleton : \(singleton)")
        
        let arg = command.arguments.first as! [String : Any]
        let item = arg["protocols"] as! [String]
        
        NAILapi.authorizeProtocols(protocolList: item, singleton: singleton){
            let pluginItem = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: $0)
            self.commandDelegate.send(pluginItem, callbackId: command.callbackId)
        }
    
    }
    
    @objc(serviceNames:)
    func serviceNames(commandItem: CDVInvokedUrlCommand){
        DispatchQueue.global(qos: .background).async {
            
            guard let names = NAILapi.serviceNames() else {
                return
            }
            let pluginResult = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: names)
            self.commandDelegate.send(pluginResult, callbackId: commandItem.callbackId)
        }
    }
    
    @objc(getEndpointUrl:)
    func getEndpointUrl(commandItem: CDVInvokedUrlCommand){
        DispatchQueue.global(qos: .background).async {
            
            let arg = commandItem.arguments.first as! [String: Any]
            
            guard let serviceName = arg["serviceName"] as? String else {
                print("getEndpointUrl: 'serviceName' Key is not found in Dictionary")
                return
            }
            guard let prtcl = arg["protocolName"] as? String else{
                print("getEndpointUrl: 'protocolName' Key is not found in Dictionary")
                return
                
            }
            
            guard let endpoint = NAILapi.getEndpointUrl(serviceName: serviceName, protocolName: prtcl ) else {
                return
            }
            let pluginResult = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: endpoint)
            self.commandDelegate.send(pluginResult, callbackId: commandItem.callbackId)
        }
    }
    
    @objc(getDisplayName:)
    func getDisplayName(commandItem: CDVInvokedUrlCommand){
        
        let arg = commandItem.arguments.first as! [String: Any]
        guard let serviceName = arg["serviceName"] as? String else {
            print("getDisplayName: 'serviceName' Key is not found in Dictionary")
            return
        }
        
        guard let displayname = NAILapi.getDisplayName(serviceName: serviceName) else {
            return
        }
        let pluginResult = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: displayname)
        self.commandDelegate.send(pluginResult, callbackId: commandItem.callbackId)
    }
    
    @objc(getServiceToken:)
    func getServiceToken(commandItem: CDVInvokedUrlCommand){
        DispatchQueue.global(qos: .background).async {
            
            let arg = commandItem.arguments.first as! [String: Any]
            
            guard let serviceName = arg["serviceName"] as? String else{
                print("getServiceToken: 'serviceName' Key is not found in Dictionary")
                return
            }
            guard let prtcl = arg["protocolName"] as? String else{
                print("getServiceToken: 'protocolName' Key is not found in Dictionary")
                return
            }
            
            guard let token = NAILapi.getServiceToken(serviceName: serviceName, protocolName: prtcl) else {
                return
            }
            /*
            do {
                let tokenjson = try JSONSerialization.data(withJSONObject: token, options: [])
                let pluginResult = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: tokenjson)
                self.commandDelegate.send(pluginResult, callbackId: commandItem.callbackId)
            } catch {return}
            */
            print("Token : ", token)
            let pluginResult = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: token)
            self.commandDelegate.send(pluginResult, callbackId: commandItem.callbackId)
    
        }
    }
    
    @objc(getServiceUrl:)
    func getServiceUrl(commandItem: CDVInvokedUrlCommand){
        
        let arg = commandItem.arguments.first as! [String : Any]
        guard let serviceName = arg["serviceName"] as? String else{
            print("getServiceUrl: 'serviceName' Key is not found in Dictionary")
            return
        }
        
        guard let serviceUrl = NAILapi.getServiceUrl(serviceName: serviceName) else {
            let pluginRes  = CDVPluginResult(status: CDVCommandStatus_ERROR, messageAs: "Login is required to use this function")
            self.commandDelegate.send(pluginRes, callbackId: commandItem.callbackId)
            return
        }
        let pluginResult = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: serviceUrl)
        self.commandDelegate.send(pluginResult, callbackId: commandItem.callbackId)
        
    }
    
    @objc(removeService:)
    func removeService(commandItem: CDVInvokedUrlCommand){
       /* 
        guard let nailTmp = getNail() else {
            let pluginRes  = CDVPluginResult(status: CDVCommandStatus_ERROR, messageAs: "Login is required to use this function")
            self.commandDelegate.send(pluginRes, callbackId: commandItem.callbackId)
            return
        }
        */
        let arg = commandItem.arguments.first as! [String : Any]
        guard let serviceName = arg["serviceName"] as? String else{
            print("getServiceUrl: 'serviceName' Key is not found in Dictionary")
            return
        }
        
        NAILapi.removeService(serviceName: serviceName)
        let pluginResult = CDVPluginResult(status: CDVCommandStatus_OK)
        self.commandDelegate.send(pluginResult, callbackId: commandItem.callbackId)
        
    }
    
    @objc(clearAllServices:)
    func clearAllServices(commandItem: CDVInvokedUrlCommand){
        NAILapi.clearAllService()
        let pluginResult = CDVPluginResult(status: CDVCommandStatus_OK)
        self.commandDelegate.send(pluginResult, callbackId: commandItem.callbackId)
    }
    
    @objc(serialize:)
    func serialize(commandItem: CDVInvokedUrlCommand){
        let serializedString = NAILapi.serialize()
        if serializedString.count == 0 {
            return
        }
        let pluginResult = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: serializedString)
        self.commandDelegate.send(pluginResult, callbackId: commandItem.callbackId)
    }
    
    @objc(parse:)
    func parse(commandItem: CDVInvokedUrlCommand){
        let arg = commandItem.arguments.first as! [String : Any]
        print(arg.keys)
        guard let serviceSpec = arg["serviceSpec"] as? String else{
            print("parse: 'serviceSpec' Key is not found in Dictionary")
            return
        }
        //check if the string is empty or not
        if serviceSpec.count == 0 {
            let pluginResult = CDVPluginResult(status: CDVCommandStatus_ERROR)
            self.commandDelegate.send(pluginResult, callbackId: commandItem.callbackId)
        }
        do{
            try NAILapi.parse(nailSerialization: serviceSpec)
            let pluginResult = CDVPluginResult(status: CDVCommandStatus_OK)
            self.commandDelegate.send(pluginResult, callbackId: commandItem.callbackId)
        }catch {
            let pluginResult = CDVPluginResult(status: CDVCommandStatus_ERROR)
            self.commandDelegate.send(pluginResult, callbackId: commandItem.callbackId)
        }
        /*
        let nailTmp = NativeAppIntegrationLayer(serializedStr: serviceSpec)
        if nailTmp.getServiceNames().count == 0 {
            let pluginResult = CDVPluginResult(status: CDVCommandStatus_ERROR)
            self.commandDelegate.send(pluginResult, callbackId: commandItem.callbackId)
        }else {
            NAIL_Cordova.nail = nailTmp
            let pluginResult = CDVPluginResult(status: CDVCommandStatus_OK)
            self.commandDelegate.send(pluginResult, callbackId: commandItem.callbackId)
        }*/
    }
    
    @objc(loggedIn:)
    func loggedIn(commandItem: CDVInvokedUrlCommand){
        let pluginResult = CDVPluginResult(status: CDVCommandStatus_OK)
        self.commandDelegate.send(pluginResult, callbackId: commandItem.callbackId)
    }
    
    /*
    func getNail()-> IdNativeAppIntegrationLayer? {
        if NAIL_Cordova.nail == nil{
            return nil
        }
        return NAIL_Cordova.nail!
        
    }*/
    
    
}
