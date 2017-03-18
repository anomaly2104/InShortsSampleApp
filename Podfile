source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '10.0'

def chocolate_import_subspec(subspec_name)
  version = '2.6'
  pod "TDTChocolate/#{subspec_name}", "~> #{version}", :inhibit_warnings => true
end

target :InShortsApp do
  pod 'AFNetworking', '~> 3.0'
  chocolate_import_subspec('FoundationAdditions')
  chocolate_import_subspec('CoreDataAdditions')
  pod 'SDWebImage', '~>3.7'
end
