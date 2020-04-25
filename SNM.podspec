Pod::Spec.new do |spec|
    spec.name             = 'SNM'
    spec.version          = '0.0.1'
    spec.license          = { :type => 'MIT' }
    spec.homepage         = 'https://github.com/Henawey/SNM'
    spec.author           = { 'Ahmed Henawey' => 'Henawey@gmailcom' }
    spec.summary          = 'Simple Network Management Project is a small abstraction wrapper layer for URLSession and URLSessionDataTask.'
    spec.source           = { :git => 'https://github.com/Henawey/SNM.git', :tag => '0.0.1' }
    spec.swift_version = '5.0'
    spec.ios.deployment_target  = '12.0'
    spec.source_files     = 'SNM/SNM/**/*.{swift}'
    spec.requires_arc     = true
  end