# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

workspace 'CatsAndModules_AndriiPermiakov.xcworkspace'
use_frameworks!

# ignore all warnings from all pods
inhibit_all_warnings!

xcodeproj 'CatsAndModules_DanyloLitvinchuk.xcodeproj'
xcodeproj 'Networking/Networking.xcodeproj'

def shared_pods
  pod 'FirebaseCrashlytics'
  pod 'FirebasePerformance'
end

target :CatsAndModules_DanyloLitvinchuk do
  xcodeproj 'CatsAndModules_DanyloLitvinchuk.xcodeproj'
  shared_pods
end

target :Networking do
  xcodeproj 'Networking/Networking.xcodeproj'
  shared_pods
end
