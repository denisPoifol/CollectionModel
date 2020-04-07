

Pod::Spec.new do |s|
  s.name             = 'CollectionModelCore'
  s.version          = '0.0.1'
  s.summary          = 'ViewModels for collectionViews and tableViews.'
  s.description      = <<-DESC
CollectionModel provide two struct to represente viewModels for collectionViews and tableViews. This viewModel are meant to be dull and contains no logic at all and be completely descriptives of the views they represent.
                       DESC

  s.homepage         = 'https://github.com/denisPoifol/CollectionModel'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Denis Poifol' => 'denis.poifol@gmail.com' }
  s.source           = { 
    :git => 'https://github.com/denisPoifol/CollectionModel.git',
    :tag => 'Core-' + s.version.to_s 
  }
  s.social_media_url = 'https://twitter.com/DenisPoifol'

  s.swift_versions = ['5.0', '5.1']
  s.ios.deployment_target = '8.0'
  s.source_files = 'Core/Sources/*'
end