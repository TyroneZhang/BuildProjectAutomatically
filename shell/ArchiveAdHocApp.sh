#! /bin/bash
# to project dir

# 工程名
PROHECT_NAME="TYColorDisk"
# 命令中加入日期 
DATE=`date "+%Y%m%d_%H%M"`
# 获取脚本的当前绝对路径
SOURCE_PATH=$(cd "$(dirname "$0")";pwd)
# 指定生成的ipa包的文件路径
PRE_IPA_PATH=$SOURCE_PATH/ipa/master/$DATE


# AD HOC
# 公网测试环境
# 一般功能会有多个target，指定其中一个
ADHOC_DEV_SCHEME_NAME="TYColorDiskDev"
# 指定ipa文件的名字
ADHOC_DEV_IPA_NAME="$ADHOC_DEV_SCHEME_NAME"_$DATE.ipa
ADHOC_DEV_BUNDLEID="com.xxxx.projectNameDev"
# app签名证书
ADHOC_DEV_CODE_SIGN_ID="iPhone Distribution: xxxxxxx (56425GF5W2)"
# app的provision file name
ADHOC_DEV_PROVISION_FILE="62327de5-1c93-45b5-b485-1f7548a83a71"
# 指定生成的ipa包的文件路径
ADHOC_DEV_IPA_PATH=$PRE_IPA_PATH/$ADHOC_DEV_SCHEME_NAME


# 内网测试环境
ADHOC_10_SCHEME_NAME="TYColorDisk10"
ADHOC_10_IPA_NAME="$ADHOC_10_SCHEME_NAME"_$DATE.ipa
ADHOC_10_BUNDLEID="com.xxxx.projectName10"
ADHOC_10_CODE_SIGN_ID="iPhone Developer: xxxxxx (56425GF5W2)"
ADHOC_10_PROVISION_FILE="62327de5-1c93-45b5-b485-1f7548a83a71"
ADHOC_10_IPA_PATH=$PRE_IPA_PATH/$ADHOC_10_SCHEME_NAME


# APP STORE
APPSTORE_SCHEME_NAME="TYColorDisk"
APPSTORE_IPA_NAME="$APPSTORE_SCHEME_NAME"_$DATE.ipa
APPSTORE_BUNDLEID="com.xxxxx.projectName"
APPSTORE_CODE_SIGN_ID="iPhone Developer: xxxxxx (56425GF5W2)"
APPSTORE_PROVISION_FILE="62327de5-1c93-45b5-b485-1f7548a83a71"
APPSTORE_IPA_PATH=$PRE_IPA_PATH/$APPSTORE_SCHEME_NAME

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
                      <string>https://ebook.ytsg.cn/app/ios/ytsg/"$SCHEME_NAME"/"$DATE"/"$IPA_NAME"</string>
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

function addDonwloadLink () {
  cd ~/Desktop/Shell/

  sed -i .bk '12i\
  <div>\
      <a href="itms-services://?action=download-manifest&url=https://ebook.xxxxx.cn/app/ios/ytsg/'$SCHEME_NAME'/'$DATE'/manifest.plist">\
          '$SCHEME_NAME''$DATE'\
      </a>\
  </div>\
  ' $1
}

function deleteUnusefuleFiles () {
  # 删除不需要的文件以及文件夹
  # 删除Build文件夹
  # 删除info.plist文件
  # 删除ModuleCache文件夹

  rm -rf $IPA_PATH/Build
  rm -f  $IPA_PATH/info.plist
  rm -rf $IPA_PATH/ModuleCache
  rm -rf $IPA_PATH/Logs

  # 打开目录
  open $IPA_PATH
} 

# 首先进入到项目根目录
  cd ~/GithubRepositories/TYColorDisk/

echo "~~~~~~~~~~~~选择打包方式(输入序号)~~~~~~~~~~~~~~~"
echo "  1 appstore"
echo "  2 adhoc"

# 读取用户输入并存到变量里
read parameter
type="$parameter"
# 判断输入
if [ "$type" = "1" ]
then
  SCHEME_NAME=$APPSTORE_SCHEME_NAME
  IPA_NAME=$APPSTORE_IPA_NAME
  BUNDLEID=$APPSTORE_BUNDLEID
  CODE_SIGN_ID="$APPSTORE_CODE_SIGN_ID"
  PROVISION_FILE="$APPSTORE_PROVISION_FILE"
  IPA_PATH=$APPSTORE_IPA_PATH
  buildIpa
  generateManifestFile
  deleteUnusefuleFiles
elif [ "$type" = "2" ]
then 
  SCHEME_NAME=$ADHOC_DEV_SCHEME_NAME
  IPA_NAME=$ADHOC_DEV_IPA_NAME
  BUNDLEID=$ADHOC_DEV_BUNDLEID
  CODE_SIGN_ID="$ADHOC_DEV_CODE_SIGN_ID"
  PROVISION_FILE="$ADHOC_DEV_PROVISION_FILE"
  IPA_PATH=$ADHOC_DEV_IPA_PATH
  buildIpa
  generateManifestFile
  deleteUnusefuleFiles
  addDonwloadLink ytsgDev.html

  # 首先进入到项目根目录
  cd ~/GithubRepositories/TYColorDisk/

  SCHEME_NAME=$ADHOC_10_SCHEME_NAME
  IPA_NAME=$ADHOC_10_IPA_NAME
  BUNDLEID=$ADHOC_10_BUNDLEID
  CODE_SIGN_ID="$ADHOC_10_CODE_SIGN_ID"
  PROVISION_FILE="$ADHOC_10_PROVISION_FILE"
  IPA_PATH=$ADHOC_10_IPA_PATH
  buildIpa
  generateManifestFile
  deleteUnusefuleFiles
  addDonwloadLink ytsg10.html
else 
  echo "无效的参数!!!"
  exit 1
fi

