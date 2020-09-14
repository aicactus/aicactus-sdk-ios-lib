# AicactusSDK IOS

AicactusSDK is an iOS client for AiCactus platform.

Analytics helps you measure your users, product, and business. It unlocks insights into your app's funnel, core business metrics, and whether you have product-market fit.


## Installation

AicactusSDK is available through [CocoaPods](http://cocoapods.org)

### CocoaPods

```ruby
    pod 'AicactusSDK', '1.0.1'
```

## Quickstart

In your application delegate’s `application:didFinishLaunchingWithOptions:` method, set up the SDK like so:

```swift
    // ContainerID AiCactus
    let configuration = AnalyticsConfiguration(writeKey: "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxx")
    // Enable this to record certain application events automatically!
    configuration.trackApplicationLifecycleEvents = true
    // Enable this to record screen views automatically!
    configuration.recordScreenViews = true
    AicactusSDK.setup(with: configuration)
```

And of course, import the SDK in the files that you use it by adding the following line:

```swift
import AicactusSDK
```

## Identify Users

The identify method is how you tell who the current user is. It takes a unique User ID, and any optional traits you know about them. You can read more about it in the identify reference.

Here’s what a basic call to identify might look like:

```swift
    AicactusSDK.shared().identify("f4ca124298",
                            traits: ["name": "Jack London"
                                    "email": "jack@aicactus.ai",
                                     "phone": "555-444-3333"])
```

That call identifies Jack by his unique User ID (f4ca124298, which is the one you know him by in your database) and labels him with name and email, phone traits.

Once you’ve added an identify call, you’re ready to move on to tracking!

## Track Actions

To get started, AicactusSDK can automatically track a few important common events, such as Application Installed, Application Updated and Application Opened. You can enable this option during initialization by adding the following lines.

```swift
    configuration.trackApplicationLifecycleEvents = true
```

You should also track events that indicate success in your mobile app, like Signed Up, Item Purchased or Article Bookmarked. We recommend tracking just a few important events. You can always add more later!

Here’s what a track call might look like when a user signs up:

```swift
    // Start with the analytics singleton
    let analytics = AicactusSDK.shared()
    // Screen
    analytics.screen("Signup")
    // create user
    analytics.track("Create Account", properties: ["Signed Up": ...])
    // Alias new user id with anonymous id
    analytics.alias("AA-BB-CC-NEW-ID")
    // Start trial
    analytics.track("Trial Started", properties: ...
```

Once you’ve added a few track calls, you’re set up!



## Flushing
By default, AicactusSDK sends (“flushes”) events from the iOS library in batches of 20, however this is configurable. You can set the flushAt value to change the batch size, or you can set it to 1 to disable batching completely.

```Note: Disable batching is not recommended. This increases battery use.```


```swift
    configuration.flushAt = 1;
```

```swift
    AicactusSDK.shared().flush()
```


## Submitting to the App Store

AicactusSDK collects the IDFA of the user’s device to use in mobile install attribution with destinations like Mobile App Tracking.

When you submit to the app store, even if you’re not currently doing mobile install attribution, check the following three boxes in the “Does this app use the Advertising Identifier (IDFA)?” on this page:

- “Attribute this app installation to a previously served advertisement”
- “Attribute an action taken within this app to a previously served advertisement”
- “I, YOUR_NAME, confirm that this app, and any third party…”

`Note: You should not check the box labeled “Serve advertisements within the app” unless you are actually going to display ads.`

## NOTE: ‼️ Before build for submitting App Store

Because Apple won’t allow x86_64, i386 architecture on app store build.

So for wrapping out x86_64, i386 architecture from framework on host app (App in which our fat framework is in use) use below script

Under “Build Phases” select “Add Run Script” and copy the contents of below script

```bash
    # Type a script or drag a script file from your workspace to insert its path.
APP_PATH="${TARGET_BUILD_DIR}/${WRAPPER_NAME}"

# This script loops through the frameworks embedded in the application and
# removes unused architectures.
find "$APP_PATH" -name '*.framework' -type d | while read -r FRAMEWORK
do
    if ( $FRAMEWORK == "AicactusSDK" )
    then
        FRAMEWORK_EXECUTABLE_NAME=$(defaults read "$FRAMEWORK/Info.plist" CFBundleExecutable)
        FRAMEWORK_EXECUTABLE_PATH="$FRAMEWORK/$FRAMEWORK_EXECUTABLE_NAME"
        echo "Executable is $FRAMEWORK_EXECUTABLE_PATH"

        EXTRACTED_ARCHS=()

        for ARCH in $ARCHS
        do
            echo "Extracting $ARCH from $FRAMEWORK_EXECUTABLE_NAME"
            lipo -extract "$ARCH" "$FRAMEWORK_EXECUTABLE_PATH" -o "$FRAMEWORK_EXECUTABLE_PATH-$ARCH"
            EXTRACTED_ARCHS+=("$FRAMEWORK_EXECUTABLE_PATH-$ARCH")
        done

        echo "Merging extracted architectures: ${ARCHS}"
        lipo -o "$FRAMEWORK_EXECUTABLE_PATH-merged" -create "${EXTRACTED_ARCHS[@]}"
        rm "${EXTRACTED_ARCHS[@]}"

        echo "Replacing original executable with thinned version"
        rm "$FRAMEWORK_EXECUTABLE_PATH"
        mv "$FRAMEWORK_EXECUTABLE_PATH-merged" "$FRAMEWORK_EXECUTABLE_PATH"
    fi
done

```
