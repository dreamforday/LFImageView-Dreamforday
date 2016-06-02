Pod::Spec.new do |s|
  s.name         = 'LFImageView'
  s.summary      = 'A packaging of SDWebImageView.'
  s.version      = '1.0.0'
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.authors      = { 'wangzhiwei' => 'wangzhiwei01@youku.com' }
  s.social_media_url = 'https://github.com/LaiFengiOS'
  s.homepage     = 'https://github.com/LaiFengiOS'
  s.platform     = :ios, '7.0'
  s.ios.deployment_target = '7.0'
  s.source       = { :git => 'https://github.com/LaiFengiOS/LFImageView.git', :tag => s.version.to_s }
  
  s.requires_arc = true
  s.source_files = 'LFImageView/**/*.{h,m}','Reachability/**/*.{h,m}'

s.dependency 'SDWebImage', '~>3.7'


end
