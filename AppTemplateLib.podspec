Pod::Spec.new do |s|
  s.name         = "AppTemplateLib"
  s.version      = "0.0.2"
  s.summary      = "AppTemplateLib for quick start."
  s.homepage     = "https://github.com/linzhiman/AppTemplateLib"
  s.license      = "MIT"
  s.author             = { "linzhiman" => "154298785@qq.com" }
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/linzhiman/AppTemplateLib.git", :tag => "#{s.version}" }
  s.source_files  = "AppTemplateLib", "AppTemplateLib/**/*.{h,m}"
end
