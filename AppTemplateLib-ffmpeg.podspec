Pod::Spec.new do |s|
  s.name         = "AppTemplateLib-ffmpeg"
  s.version      = "0.0.2"
  s.summary      = "AppTemplateLib for quick start."
  s.homepage     = "https://github.com/linzhiman/AppTemplateLib"
  s.license      = { :type => "MIT", :file => "ffmpeg-0.0.2/LICENSE" }
  s.author             = { "linzhiman" => "154298785@qq.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :http => "https://github.com/linzhiman/ffmpeg/archive/0.0.2.zip" }
  s.source_files = 'ffmpeg-0.0.2/FFmpeg-iOS/include/**/*.h'
  s.public_header_files = 'ffmpeg-0.0.2/FFmpeg-iOS/include/**/*.h'
  s.preserve_paths = 'ffmpeg-0.0.2/FFmpeg-iOS/lib/*.a'
  s.libraries = 'avcodec','avdevice','avfilter','avformat','avutil','swresample','swscale'
  s.xcconfig = {
    'LIBRARY_SEARCH_PATHS' => '"$(PODS_ROOT)/AppTemplateLib-ffmpeg/ffmpeg-0.0.2/FFmpeg-iOS/lib/"',
    'HEADER_SEARCH_PATHS' => '$(inherited) "$(PODS_ROOT)/AppTemplateLib-ffmpeg/ffmpeg-0.0.2/FFmpeg-iOS/include"'
}
end
