

Pod::Spec.new do |s|
  s.name             = 'CollectionModel'
  s.version          = '0.4.0'
  s.summary          = 'ViewModels for collectionViews and tableViews.'
  s.description      = <<-DESC
CollectionModel provide two struct to represente viewModels for collectionViews and tableViews. This viewModel are meant to be dull and contains no logic at all and be completely descriptives of the views they represent.
                       DESC

  s.homepage         = 'https://github.com/denisPoifol/CollectionModel'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Denis Poifol' => 'denis.poifol@gmail.com' }
  s.source           = { :git => 'https://github.com/denisPoifol/CollectionModel.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/DenisPoifol'

  s.swift_versions = ['5.0', '5.1']
  s.ios.deployment_target = '9.0'
  s.default_subspec = 'Animation'

  s.subspec 'Core' do |ss|
    ss.ios.dependency 'CollectionModelCore', '0.3.0'
  end

  s.subspec 'Animation' do |ss|
    ss.ios.dependency 'CollectionModelAnimation', '0.0.2'
  end
end
