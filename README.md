# TYColorDisk
Copyright (c) 2015 Tyrone Zhang. All rights reserved.
[git access to ](https://github.com/TyroneZhang).

一套公司级别的iOS自动化打包并通过web下载测试的工具


前言

此文章主要目的在于介绍这套工具来规范公司iOS端从提交代码到服务器，再到测试组打开一个web来更新或者下载beta版本的app。那这样做有什么好处呢？
1、所有测试人员不需要找开发人员来一个个手机的安装了，并且有时候遇到xcode出问题，等很长时间都安装不了；
2、命令打包app的时间比用Xcode打包的效率更高；
3、能把握住开发人员的开发时间，简单来说就是如果三天是新需求的deadline，那么第四天的早上测试组从网页端下载下来的代码就是最新的app；
4、减少每次更新app由于粗心造成的一些配置错误；
5、整个从打包到测试再到appstore上线的流程可以完全被独立出来，不用开发人员过多的参与。
所以将工作效率化、模块化、规范化是一个不错的事情。
那么这套工具需要准备些什么知识呢？
1、apple提供到xcodebuild、xcrun命令工具；
2、shell脚本基础知识；
3、html基础知识；
3、ftp文件上传知识；

So, let’s go!

xcodebuild预编译app
苹果公司提供了一个命令工具xcodebuild，故名思意就是build xcode project and workspace，用于与工程有关的一些命令。具体的使用以及说明可以使用man xcodebuild命令查看。其实xcodebuild足以用来编译，打包成arvhive并导出ipa文件，那xcrun可以做的事情是什么呢？xcrun可以将xcodebuild编译出来的.app文件打包成ipa文件。那这两种打包成ipa方式又有什么区别呢？仅使用xcodebuild的结果和使用Xcode编译打包的结果是一致的，并且最终的ipa也可以正常安装使用。而第一种xcodebuild+xcrun的结果略大些，但是ipa也是可以正常使用的。这时需要了解下他们的区别。
xcodebuild方式：
function buildIpa () {
  # clean一下工程
  xcodebuild clean -configuration Release -alltargets

  # build project
  # -project 指定工作空间
  # -scheme 指定对哪个target对应的scheme进行编译
  # -configuration 指定release或debug版本
  # -sdk 指定运行的sdk
  # -derivedDataPath 指定输出路径
  xcodebuild -project $PROHECT_NAME.xcodeproj \
  -scheme $SCHEME_NAME \
  -configuration Release \
  -sdk iphoneos build \
  CODE_SIGN_IDENTITY="$CODE_SIGN_ID" \
  PROVISIONING_PROFILE="$PROVISION_FILE" \
  PRODUCT_BUNDLE_IDENTIFIER="$BUNDLEID" \
  -archivePath $IPA_PATH/Build/$"SCHEME_NAME"_Adhoc.xcarchive clean archive build \
  -derivedDataPath $IPA_PATH
  if [ ! -e $IPA_PATH/Build/$"SCHEME_NAME"_Adhoc.xcarchive ]; then
    echo $IPA_PATH/Build/$"SCHEME_NAME"_Adhoc.xcarchive
    echo "=============="$SCHEME_NAME"================\n"
    echo "\n"
    echo "\n"
    echo "build error!!!"
    echo "\n"
    echo "\n"
    echo "==============================\n"
    exit 1
  fi


  # 导出ipa
  # -archivePath  上一步编译结果的*.xcarchive文件路径
  # -exportPath ipa文件输出路径
  xcodebuild -exportArchive -archivePath $IPA_PATH/Build/$"SCHEME_NAME"_Adhoc.xcarchive \
  -exportPath $IPA_PATH/$IPA_NAME
   if [ ! -e $IPA_PATH/$IPA_NAME ]; then
    echo "==============="$SCHEME_NAME"===============\n"
    echo "\n"
    echo "\n"
    echo "build ipa error!!!"
    echo "\n"
    echo "\n"
    echo "==============================\n"
    exit 1
  fi
}

xcrun方式：
# build project
# -workspace 指定工作空间
# -scheme 指定对哪个target对应的scheme进行编译
# -configuration 指定release或debug版本
# -sdk 指定运行的sdk
# -derivedDataPath 指定输出路径
xcodebuild -workspace 日历demo.xcworkspace \
-scheme "$SCHEME_NAME" \
-configuration Release \
-sdk iphoneos build \
CODE_SIGN_IDENTITY="$CODE_SIGN_ID" \
PROVISIONING_PROFILE="$PROVISION_FILE" \
-derivedDataPath $IPA_PATH

if [ -e $IPA_PATH ]; then
   echo "xcodebuild successful"
else
   echo "error:Build failed!"
   exit 1
fi

# xcrun .ipa
# -v 上一步编译结果的app文件路径
# -O ipa文件输出路径
xcrun -sdk iphoneos PackageApplication \
   -v $IPA_PATH/Build/Products/Release-iphoneos/"$SCHEME_NAME".app \
   -O $IPA_PATH/$IPA_NAME
if [ -e $IPA_PATH/$IPA_NAME ]; then
   echo "\n-------------------------\n\n\n"
   echo "Configurations! Build Successful!"
   echo "\n\n\n-----------------------\n\n"
   echo "Current Branch log:"
   git log -2
   open $IPA_PATH
else
   echo "\n--------------------------\n\n\n"
   echo "error: Create ipa failed!!"
   echo "\nPlease check the reson of failure and contact developers, thanks!"
   echo "\n-----------------------------\n"
fi



打包ad hoc app通过web下载
需要的文件有manifest、html以及对应的包名
思路就是当打包完ipa文件后，通过shell脚本自动生成manifest.plist文件，然后再通过脚本自动在对应的html文件中插入新的下载链接。最终想要达到的效果就是这样：

最新生成下载链接放在最前面，以app名+年月日_时分为下载名

下载链接指向的内容是manifest文件所在的位置，那么manifest包含什么东西呢？首先是https的ipa链接，其次包含app bundleid和title对应的app名，这个文件safari能够识别，去下载对应的ipa文件。


生成manifest的代码：
function generateManifestFile () {
  # 生成manifest.plist文件
  MANIFEST_PATH="$IPA_PATH"/manifest.plist
  echo "<?xml version=\"1.0\" encoding=\"UTF-8\"?>
  <!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">
  <plist version=\"1.0\">
  <dict>
      <key>items</key>
      <array>
          <dict>
              <key>assets</key>
              <array>
                  <dict>
                      <key>kind</key>
                      <string>software-package</string>
                      <key>url</key>
                      <string>https://xxxxxx/ios/ytsg/"$SCHEME_NAME"/"$DATE"/"$IPA_NAME"</string>
                  </dict>
              </array>
              <key>metadata</key>
              <dict>
                  <key>bundle-identifier</key>
                  <string>"$BUNDLEID"</string>
                  <key>bundle-version</key>
                  <string>1.0</string>
                  <key>kind</key>
                  <string>software</string>
                  <key>title</key>
                  <string>"$SCHEME_NAME"</string>
              </dict>
          </dict>
      </array>
  </dict>
  </plist>" > "$MANIFEST_PATH"
}

向html文件添加下载链接的代码：
function addDonwloadLink () {
  cd ~/Desktop/脚本/

  sed -i .bk '12i\
  <div>\
      <a href="itms-services://?action=download-manifest&url=https://ebook.ytsg.cn/app/ios/ytsg/'$SCHEME_NAME'/'$DATE'/manifest.plist">\
          '$SCHEME_NAME''$DATE'\
      </a>\
  </div>\
  ' $1
}



