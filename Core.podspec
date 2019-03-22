#
#  Be sure to run `pod spec lint KJZTool.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #

  s.name         = "VCRCore"
  s.version      = "0.0.1"
  s.summary      = "A short description of Core."

  # This description is used to generate tags and improve search results.
  #   * Think: What does it do? Why did you write it? What is the focus?
  #   * Try to keep it short, snappy and to the point.
  #   * Write the description between the DESC delimiters below.
  #   * Finally, don't worry about the indent, CocoaPods strips it!
  s.description  = <<-DESC
                    "hello world"
                   DESC

  s.homepage     = "https://github.com/vcc1235/Core.git"
  # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"


  # ―――  Spec License  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Licensing your code is important. See http://choosealicense.com for more info.
  #  CocoaPods will detect a license file if there is a named LICENSE*
  #  Popular ones are 'MIT', 'BSD' and 'Apache License, Version 2.0'.
  #
  s.ios.deployment_target = '8.0'
  #s.license      = "MIT (example)"
  s.license      = { :type => "MIT", :file => "LICENSE" }


  # ――― Author Metadata  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Specify the authors of the library, with email addresses. Email addresses
  #  of the authors are extracted from the SCM log. E.g. $ git log. CocoaPods also
  #  accepts just a name if you'd rather not provide an email address.
  #
  #  Specify a social_media_url where others can refer to, for example a twitter
  #  profile URL.
  #

  s.author             = { "vcc1235" => "1041497818@qq.com" }
  # Or just: s.author    = "vcc1235"
  # s.authors            = { "vcc1235" => "1041497818@qq.com" }
  # s.social_media_url   = "http://twitter.com/vcc1235"

  # ――― Platform Specifics ――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  If this Pod runs only on iOS or OS X, then specify the platform and
  #  the deployment target. You can optionally include the target after the platform.
  #

  # s.platform     = :ios
  # s.platform     = :ios, "5.0"

  #  When using multiple platforms
  # s.ios.deployment_target = "5.0"
  # s.osx.deployment_target = "10.7"
  # s.watchos.deployment_target = "2.0"
  # s.tvos.deployment_target = "9.0"


  # ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Specify the location from where the source should be retrieved.
  #  Supports git, hg, bzr, svn and HTTP.
  #
  #   http://192.168.10.117/IOS_Common/KJZTool.git
  s.source       = { :git => "https://github.com/vcc1235/Core.git" }


  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  CocoaPods is smart about how it includes source code. For source files
  #  giving a folder will include any swift, h, m, mm, c & cpp files.
  #  For header files it will include any header in the folder.
  #  Not including the public_header_files will make all headers public.
  #

  s.source_files  = "STTFrameworks/STTFrameworks/STTFrameworks.h"
  s.public_header_files = "STTFrameworks/STTFrameworks/STTFrameworks.h"

  # s.public_header_files = "Classes/**/*.h"


  # ――― Resources ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  A list of resources included with the Pod. These are copied into the
  #  target bundle with a build phase script. Anything else will be cleaned.
  #  You can preserve files from being cleaned, please don't preserve
  #  non-essential files like tests, examples and documentation.
  #

  # s.resource  = "icon.png"
  # s.resources = "Resources/*.png"

  # s.preserve_paths = "FilesToSave", "MoreFilesToSave"


  # ――― Project Linking ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Link your library with frameworks, or libraries. Libraries do not include
  #  the lib prefix of their name.
  #
    s.dependency 'AFNetworking', '~> 3.1.0'
    s.dependency 'SVProgressHUD'
    s.dependency 'Masonry' 
    s.dependency 'XMLDictionary'
    
    path = 'STTFrameworks/STTFrameworks/'
    
    s.subspec 'Category' do |ss|
        ss.source_files = path+'Category/Category.h'
        ss.subspec 'CALayer' do |sss|
            sss.source_files = path+'Category/CALayer/*{.h,.m}'
        end
        ss.subspec 'UINavigationController' do |sss|
            sss.source_files = path+'Category/UINavigationController/*{.h,.m}'
        end
        ss.subspec 'UIButton' do |sss|
            sss.source_files = path+'Category/UIButton/*{.h,.m}'
        end
        ss.subspec 'UIImage' do |sss|
            sss.source_files = path+'Category/UIImage/*{.h,.m}'
        end
        ss.subspec 'UIView' do |sss|
            sss.source_files = path+'Category/UIView/*{.h,.m}'
        end
        ss.subspec 'NSString' do |sss|
            sss.source_files = path+'Category/NSString/*{.h,.m}'
        end
        ss.subspec 'UITextField' do |sss|
            sss.source_files = path+'Category/UITextField/*{.h,.m}'
        end
        ss.subspec 'NSNumber' do |sss|
            sss.source_files = path+'Category/NSNumber/*{.h,.m}'
        end
        #ss.subspec 'NSObject' do |sss|
        #    sss.source_files = path+'Category/NSObject/*{.h,.m}'
        #end
        ss.subspec 'NSArray' do |sss|
            sss.source_files = path+'Category/NSArray/*{.h,.m}'
        end
        #ss.subspec 'NSBundle' do |sss|
        #    sss.source_files = path+'Category/NSBundle/*{.h,.m}'
        #end
        ss.subspec 'NSDictionary' do |sss|
            sss.source_files = path+'Category/NSDictionary/*{.h,.m}'
        end
        ss.subspec 'UIColor' do |sss|
            sss.source_files = path+'Category/UIColor/*{.h,.m}'
        end
    end
    #   s.subspec 'Until' do |ss|
    #    ss.dependency s.name+'/Category/NSDictionary'
    #    ss.source_files = path+'Until/*{.h,.m}'
    # end
    #s.subspec 'STManage' do |ss|
    #    ss.dependency s.name+'/Category'
    #    ss.source_files = path+'STManage/*{.h,.m}'
    #end
    
    s.subspec 'Core' do |ss|
        ss.source_files = path+'Core/*{.h,.m}'
    end
    s.subspec 'Lib' do |ss|
        ss.subspec 'FuncTool' do |sss|
            sss.dependency s.name+'/Category'
            sss.source_files = path+'Lib/Func/*{.h,.m}'
        end
    end
    

  # s.framework  = "SomeFramework"
  # s.frameworks = "SomeFramework", "AnotherFramework"
  #s.resource = path+'STResource.bundle'
  # s.library   = "iconv"
  # s.libraries = "iconv", "xml2"


  # ――― Project Settings ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  If your library depends on compiler flags you can set them in the xcconfig hash
  #  where they will only apply to your library. If you depend on other Podspecs
  #  you can include multiple dependencies to ensure it works.

    s.requires_arc = true
    s.xcconfig = {'OTHER_LDFLAGS' => '-ObjC'}
  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # s.dependency "JSONKit", "~> 1.4"

end
