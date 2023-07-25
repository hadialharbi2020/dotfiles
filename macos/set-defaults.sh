#!/usr/bin/env bash
echo 'start osx/set-defaults.sh'

# اطلب كلمة مرور المسؤول مُسبقًا
sudo -v

# استمرارية: تحديث الطابع الزمني الحالي لـ 'sudo' حتى انتهاء `.osx`
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

###############################################################################
# واجهة المستخدم العامة                                                      #
###############################################################################

# تعطيل آثار الصوت عند بدء التشغيل
sudo nvram SystemAudioVolume=" "

# شريط القائمة: تعطيل الشفافية
#defaults write NSGlobalDomain AppleEnableMenuBarTransparency -bool false

# تعيين حجم أيقونات الشريط الجانبي إلى متوسط
defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 2

# زيادة سرعة تغيير حجم النافذة للتطبيقات الكوكوا
defaults write NSGlobalDomain NSWindowResizeTime -float 0.001

# توسيع لوحة الحفظ افتراضيًا
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

# توسيع لوحة الطباعة افتراضيًا
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

# حفظ على القرص (وليس في iCloud) افتراضيًا
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# إنهاء تلقائي لتطبيق الطابعة بمجرد الانتهاء من الطباعة
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

# تعطيل مربع حوار "هل أنت متأكد من أنك تريد فتح هذا التطبيق؟"
defaults write com.apple.LaunchServices LSQuarantine -bool false

# تعطيل استئناف النظام على مستوى النظام بأكمله
defaults write NSGlobalDomain NSQuitAlwaysKeepsWindows -bool false

# تعطيل إنهاء تلقائي للتطبيقات الغير نشطة
defaults write NSGlobalDomain NSDisableAutomaticTermination -bool true

# تعطيل مرسل التقارير عن الأعطال
#defaults write com.apple.CrashReporter DialogType -string "none"

# إظهار عناوين IP واسم الجهاز ونسخة نظام التشغيل عند النقر على الساعة
# في نافذة تسجيل الدخول
sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName

# تعطيل اقتباس العبارات الذكي لأنها مزعجة أثناء كتابة الشيفرة
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

# تعطيل الشرطات الذكية لأنها مزعجة أثناء كتابة الشيفرة
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

###############################################################################
# تعديلات محددة لأجهزة التخزين بالحالة الصلبة                                  #
###############################################################################

# تعطيل السبات (يسرّع دخول وضع السكون)
sudo pmset -a hibernatemode 0

# تعطيل مستشعر الحركة المفاجئة لأنه غير مفيد لأقراص الحالة الصلبة
sudo pmset -a sms 0

###############################################################################
# لوحة اللمس والفأرة ولوحة المفاتيح وملحقات بلوتوث والإدخال                     #
###############################################################################

# زيادة جودة الصوت لسماعات/سماعات البلوتوث
defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Max (editable)" 80
defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" 80
defaults write com.apple.BluetoothAudioAgent "Apple Initial Bitpool (editable)" 80
defaults write com.apple.BluetoothAudioAgent "Apple Initial Bitpool Min (editable)" 80
defaults write com.apple.BluetoothAudioAgent "Negotiated Bitpool" 80
defaults write com.apple.BluetoothAudioAgent "Negotiated Bitpool Max" 80
defaults write com.apple.BluetoothAudioAgent "Negotiated Bitpool Min" 80

# تمكين الوصول الكامل لواجهة المستخدم لجميع العناصر التحكم
# (على سبيل المثال، تمكين مفتاح Tab في الحوارات المنبثقة)
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# تعيين اللغة وتنسيقات النص
# ملاحظة: إذا كنت في الولايات المتحدة، استبدل "EUR" بـ "USD"، و "Centimeters" بـ "Inches"، "en_GB" بـ "en_US" و "true" بـ "false".
defaults write NSGlobalDomain AppleLanguages -array "en"
defaults write NSGlobalDomain AppleLocale -string "en_GB@currency=EUR"
defaults write NSGlobalDomain AppleMeasurementUnits -string "Centimeters"
defaults write NSGlobalDomain AppleMetricUnits -bool true

# تعيين المنطقة الزمنية؛ انظر "systemsetup -listtimezones" لقائمة قيم أخرى
systemsetup -settimezone "Europe/Brussels" > /dev/null

# تعطيل التصحيح التلقائي
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# توقف iTunes عن الاستجابة لمفاتيح الوسائط في لوحة المفاتيح
#launchctl unload -w /System/Library/LaunchAgents/com.apple.rcd.plist 2> /dev/null

###############################################################################
# الشاشة                                                                     #
###############################################################################

# طلب كلمة مرور فوريا بعد الدخول في وضع السكون أو الشاشة العاكسة
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

###############################################################################
# الباحث                                                                     #
###############################################################################

# تعيين سطح المكتب كمكان افتراضي لنوافذ الباحث الجديدة
# بالنسبة لمسارات أخرى، استخدم `PfLo` و `file:///full/path/here/`
defaults write com.apple.finder NewWindowTarget -string "PfDe"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/Desktop/"

# عرض الأيقونات لأقراص الصلب والخوادم والوسائط القابلة للإزالة على سطح المكتب
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

# الباحث: عرض جميع ملحقات اسم الملف
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# الباحث: السماح باختيار النص في النظرة السريعة
defaults write com.apple.finder QLEnableTextSelection -bool true

# عرض المسار الكامل للملف في عنوان نافذة الباحث
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# عند القيام بعملية بحث، ابحث في المجلد الحالي بشكل افتراضي
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# تعطيل التحذير عند تغيير امتداد الملف
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# تجنب إنشاء ملفات .DS_Store على وحدات الشبكة
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# تعطيل التحقق من صحة الصورة القرص
defaults write com.apple.frameworks.diskimages skip-verify -bool true
defaults write com.apple.frameworks.diskimages skip-verify-locked -bool true
defaults write com.apple.frameworks.diskimages skip-verify-remote -bool true

# استخدم عرض القائمة في جميع نوافذ الباحث افتراضيًا
# رموز ذات أربعة أحرف لطرق العرض الأخرى: `icnv`، `clmv`، `Flwv`
defaults write com.apple.finder FXPreferredViewStyle -string "clmv"

# تعطيل التحذير قبل تفريغ سلة المهملات
defaults write com.apple.finder WarnOnEmptyTrash -bool false

# عرض مجلد ~/Library
chflags nohidden ~/Library

# عرض مجلد ~/Users
chflags nohidden /Users

# توسيع لوحة معلومات الملفات التالية:
# "General"، "Open with"، و "Sharing & Permissions"
defaults write com.apple.finder FXInfoPanesExpanded -dict \
	General -bool true \
	OpenWith -bool true \
	Privileges -bool true

###############################################################################
# لقطات الشاشة                                                              #
###############################################################################

# تعيين مكان لقطة الشاشة الافتراضي
#defaults write com.apple.screencapture "location" -string "~/Documents/Screenshots"

# استبعاد التاريخ والوقت من أسماء ملفات لقطات الشاشة
defaults write com.apple.screencapture "include-date" -bool false

# تغيير اسم ملف لقطة الشاشة الافتراضي
defaults write com.apple.screencapture "name" -string "screenshot"

###############################################################################
# قفصة المهام والواجهة الجانبية وزوايا الساخنة                                #
###############################################################################

# منع تمايز التطبيقات في القفصة
defaults write com.apple.dock no-bouncing -bool true

# تعيين حجم أيقونات القفصة إلى 72 بكسل
defaults write com.apple.dock tilesize -int 72

# إخفاء أضواء المؤشر للتطبيقات المفتوحة في القفصة
defaults write com.apple.dock show-process-indicators -bool false

# مسح كل الأيقونات (الافتراضي) للتطبيقات من القفصة
# هذا يكون مفيدًا فقط عند إعداد جهاز Mac جديد، أو إذا لم تستخدم
# القفصة لتشغيل التطبيقات.
defaults write com.apple.dock persistent-apps -array ""

# تعطيل الواجهة الجانبية
defaults write com.apple.dashboard mcx-disabled -bool true

# عدم عرض الواجهة الجانبية كمساحة
defaults write com.apple.dock dashboard-in-overlay -bool true

# عدم إعادة ترتيب مساحات العمل تلقائيًا استنادًا إلى الاستخدام الأكثر حداثة
defaults write com.apple.dock mru-spaces -bool false

# جعل أيقونات القفصة للتطبيقات المخفية شفافة
defaults write com.apple.dock showhidden -bool true

###############################################################################
# Safari وWebKit                                                             #
###############################################################################

# تمكين قائمة تصحيح أخطاء Safari
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true

# تمكين قائمة Develop ومفتش الويب في Safari
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true

# عدم عرض الإشعار المزعج عند إنهاء iTerm
#defaults write com.googlecode.iterm2 PromptOnQuit -bool false

# منع Time Machine من طلب استخدام وحدات الأقراص الصلبة الجديدة كحجم نسخ احتياطي
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

###############################################################################
# مراقب النشاط                                                              #
###############################################################################

# عرض النافذة الرئيسية عند بدء تشغيل مراقب النشاط
defaults write com.apple.ActivityMonitor OpenMainWindow -bool true

# تجسيد استخدام وحدة المعالجة المركزية في رمز مراقب النشاط في القفصة
defaults write com.apple.ActivityMonitor IconType -int 5

# عرض جميع العمليات في مراقب النشاط
defaults write com.apple.ActivityMonitor ShowCategory -int 0

# فرز نتائج مراقب النشاط حسب استخدام وحدة المعالجة المركزية
defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
defaults write com.apple.ActivityMonitor SortDirection -int 0

###############################################################################
# دفتر العناوين والواجهة الجانبية وأداة iCal وTextEdit وDisk Utility                #
###############################################################################

# استخدام وضع النص العادي لمستندات TextEdit الجديدة
defaults write com.apple.TextEdit RichText -int 0

# فتح وحفظ الملفات بتنسيق UTF-8 في TextEdit
defaults write com.apple.TextEdit PlainTextEncoding -int 4
defaults write com.apple.TextEdit PlainTextEncodingForWrite -int 4

###############################################################################
# الرسائل                                                                    #
###############################################################################

# تعطيل اقتباس العبارات الذكي لأنها مزعجة عند الرسائل التي تحتوي على كود
defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "automaticQuoteSubstitutionEnabled" -bool false

# تعطيل التحقق المستمر للتهجئة
defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "continuousSpellCheckingEnabled" -bool false

###############################################################################
# قتل التطبيقات المتأثرة                                                     #
###############################################################################

for app in "Activity Monitor" "Address Book" "Calendar" "Contacts" "cfprefsd" \
	"Dock" "Finder" "Mail" "Messages" "Safari" "SizeUp" "SystemUIServer" \
	"Terminal" "Transmission" "Twitter" "iCal"; do
	killall "${app}" > /dev/null 2>&1
done
echo "تم. يُرجى ملاحظة أن بعض هذه التغييرات تتطلب تسجيل الخروج/إعادة التشغيل للتأثير."
