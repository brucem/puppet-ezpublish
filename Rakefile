require 'bundler'
Bundler.require(:rake)
require 'rake/clean'

require 'puppetlabs_spec_helper/rake_tasks'
require 'puppet-lint/tasks/puppet-lint'
#require 'puppet-lint'

PuppetLint.configuration.with_filename = true
# Ignore any spec manifests as well as the install.pp as it's a bit rubbish
PuppetLint.configuration.ignore_paths = ["spec/**/*.pp", "manifests/install.pp"]
PuppetLint.configuration.send('disable_class_inherits_from_params_class')
PuppetLint.configuration.send('disable_80chars')

CLEAN.include('spec/fixtures/', 'doc', 'pkg')
CLOBBER.include('.tmp', '.librarian')

# Use librarian-puppet to manage fixtures instead of .fixtures.yml
# offers more possibilities like explicit version management, forge downloads,... 
task :librarian_spec_prep do
  sh "librarian-puppet install --path=spec/fixtures/modules/"
end
task :spec_prep => :librarian_spec_prep
 
task :default => [:spec]
