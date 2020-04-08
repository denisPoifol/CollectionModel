

Pod::Spec.new do |s|
  s.name             = 'CollectionModelAnimation'
  s.version          = '0.0.1'
  s.summary          = 'Animating collection view and tableView reloads when using CollectionModel'
  s.description      = <<-DESC
The addition of CollectionModelAnimation is to automatically animate changes to collection views and table views. This is achieved by using DifferenceKit.
                       DESC

  s.homepage         = 'https://github.com/denisPoifol/CollectionModel'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Denis Poifol' => 'denis.poifol@gmail.com' }
  s.source           = {
    :git => 'https://github.com/denisPoifol/CollectionModel.git',
    :tag => 'Animation-' + s.version.to_s
  }
  s.social_media_url = 'https://twitter.com/DenisPoifol'

  s.swift_versions = ['5.0', '5.1']
  s.ios.deployment_target = '9.0'
  s.source_files = 'Animation/Sources/*'
  s.ios.dependency 'CollectionModelCore', '0.0.1'
  s.ios.dependency 'DifferenceKit', '1.1.5'
end