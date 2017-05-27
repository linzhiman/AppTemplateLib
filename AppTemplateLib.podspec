Pod::Spec.new do |s|
  s.name         = "AppTemplateLib"
  s.version      = "0.0.4"
  s.summary      = "AppTemplateLib for quick start."
  s.homepage     = "https://github.com/linzhiman/AppTemplateLib"
  s.license      = "MIT"
  s.author             = { "linzhiman" => "154298785@qq.com" }
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/linzhiman/AppTemplateLib.git", :tag => "#{s.version}" }
  s.default_subspecs = "Utility", "Model", "UI"
  s.subspec 'Utility' do |sp|
      sp.source_files = "AppTemplateLib/Utility/*.{h,m}"
  end
  s.subspec 'Model' do |sp|
      sp.source_files = "AppTemplateLib/Model/*.{h,m}"
      sp.dependency "AppTemplateLib/Utility"
  end
  s.subspec 'UI' do |sp|
      sp.source_files = "AppTemplateLib/UI/*.{h,m}"
      sp.dependency "AppTemplateLib/Utility"
  end
end
