# robobo-speech-ios

The speech library provides an easy interface for accessing the speech capabilities of the smartphone. This library contains the Speech production module that gives to the robot the capacity to talk.

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

In the example we can see how to instance the speech module and make it say a text:

```swift
class ViewController: UIViewController, RoboboManagerDelegate {

    var manager : RoboboManager!
    var speechModule :ISpeechProductionModule!
    var remote :IRemoteControlModule!
    var proxy: ProxyTest!
    var text :String = "Robobo combines a simple mobile base with your smartphone to create the next generation of educational robots. The Robobo base is the body while your smartphone is the brain."
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manager = RoboboManager()
        proxy = ProxyTest()
        manager.addFrameworkDelegate(self)
        do{
            try manager.startup()

            var module = try manager.getModuleInstance("ISpeechProductionModule")
            speechModule = module as? ISpeechProductionModule

            module = try manager.getModuleInstance("IRemoteControlModule")
            remote = module as? IRemoteControlModule
        }catch{
            print(error)
        }

        remote.registerRemoteControlProxy(proxy)

        //var args: [String:String] = [:]
        //args["text"]=text
        //var c: Command = Command("TALK",0,args)
        //remote.queueCommand(c)

        speechModule.setLanguage("en_US")
        speechModule.sayText(text, .priority_low)

    }
}
````
## Requirements

This module depends on robobo-framework-ios-pod and robobo-remote-control-ios, add it to your podfile as follows:

```ruby
pod 'robobo-framework-ios-pod','~>0.1.0'
pod 'robobo-remote-control-ios','~>0.1.4'
```

## Installation

robobo-speech-ios is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'robobo-speech-ios'
```

Also add the following lines to the beginning of `your Podfile, to allow the download of dependencies through our private Podspec repository:

```ruby
source "https://github.com/mintforpeople/mint-podspec-repo.git"
source "https://github.com/CocoaPods/Specs.git"
```

When importing it in your code, be aware that the dashes on the module name are converted to underscores:

```swift
import robobo_speech_ios
```

To allow loading the modules from the robobo framework, they must be declared on the ```modules.plist``` file in the desired load order:
```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
    <dict>
        <key>1.IRemoteControlModule</key>
            <string>robobo_remote_control_ios.RemoteControlModule</string>
        <key>2.ISpeechProductionModule</key>
            <string>robobo_speech_ios.SpeechProductionModuleImplementation</string>
    </dict>
</plist>
```

## Author

luis.llamas@mintforpeople.com

## License

robobo-speech-ios is available under the Apache 2.0 license. See the LICENSE file for more info.

***
<!-- 
    ROSIN acknowledgement from the ROSIN press kit
    @ https://github.com/rosin-project/press_kit
-->

<a href="http://rosin-project.eu">
  <img src="http://rosin-project.eu/wp-content/uploads/rosin_ack_logo_wide.png" 
       alt="rosin_logo" height="60" >
</a>

Supported by ROSIN - ROS-Industrial Quality-Assured Robot Software Components.  
More information: <a href="http://rosin-project.eu">rosin-project.eu</a>

<img src="http://rosin-project.eu/wp-content/uploads/rosin_eu_flag.jpg" 
     alt="eu_flag" height="45" align="left" >  

This project has received funding from the European Union’s Horizon 2020  
research and innovation programme under grant agreement no. 732287. 
