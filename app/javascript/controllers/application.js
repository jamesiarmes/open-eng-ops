import { Application } from '@hotwired/stimulus'
import 'chartkick'
import 'Chart.bundle'
import 'chartjs-plugin-deferred'

const application = Application.start()

Chart.register(ChartDeferred)

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }
