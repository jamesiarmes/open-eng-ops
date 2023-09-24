import { Application } from '@hotwired/stimulus'
import 'chartkick'
import 'Chart.bundle'
import 'chartjs-plugin-deferred'
import { far } from '@fortawesome/free-regular-svg-icons'
import { fas } from '@fortawesome/free-solid-svg-icons'
import { fab } from '@fortawesome/free-brands-svg-icons'
import { library } from '@fortawesome/fontawesome-svg-core'
import '@fortawesome/fontawesome-free'
import jQuery from 'jquery'

library.add(far, fas, fab)

const application = Application.start()

Chart.register(ChartDeferred)

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

// Add jQuery into the mix
window.jQuery = jQuery
window.$ = jQuery

export { application }
