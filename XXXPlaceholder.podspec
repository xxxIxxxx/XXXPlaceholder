Pod::Spec.new do |s|
  s.name         = 'XXXPlaceholder'
  s.version      = '0.0.2'
  s.summary      = 'tableView、CollectionView、View无数据占位图，加载错误占位图'
  s.homepage     = 'https://github.com/xxxIxxxx/XXXPlaceholder'
  s.license      = 'MIT'
  s.authors      = {'i2yf' => 'i2yf@foxmail.com'}
  s.platform     = :ios
  s.platform     = :ios, "8.0"
  s.source       = {:git => 'https://github.com/xxxIxxxx/XXXPlaceholder.git', :tag => s.version}
  s.source_files = 'XXXPlaceholderViewDemo/XXXPlaceholder/*.{h,m}'
  s.requires_arc = true
end