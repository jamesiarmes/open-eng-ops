# frozen_string_literal: true

# Pin npm packages by running ./bin/importmap

pin 'application', preload: true
pin '@hotwired/turbo-rails', to: 'turbo.min.js', preload: true
pin '@hotwired/stimulus', to: 'stimulus.min.js', preload: true
pin '@hotwired/stimulus-loading', to: 'stimulus-loading.js', preload: true
pin 'popper', to: 'popper.js', preload: true
pin_all_from 'app/javascript/controllers', under: 'controllers'
pin 'mdb-ui-kit', to: 'mdb-ui-kit/mdb', preload: true
pin 'detect-autofill', to: 'https://ga.jspm.io/npm:detect-autofill@1.1.4/dist/detect-autofill.js'
pin 'chartkick', to: 'chartkick.js'
pin 'Chart.bundle', to: 'Chart.bundle.js'
pin 'chartjs-plugin-deferred', to: 'https://cdn.jsdelivr.net/npm/chartjs-plugin-deferred@2.0.0/dist/chartjs-plugin-deferred.min.js'
