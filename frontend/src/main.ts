import { bootstrapApplication } from '@angular/platform-browser';
import { appConfig } from './app/app.config';
import { AppComponent } from './app/app.component';

if ('scrollRestoration' in history) {
  history.scrollRestoration = 'manual';
}

const initialHash = window.location.hash.replace('#', '');
if (initialHash) {
  sessionStorage.setItem('portfolio-pending-hash', initialHash);
  history.replaceState(null, '', window.location.pathname + window.location.search);
  window.scrollTo(0, 0);
}

bootstrapApplication(AppComponent, appConfig).catch((err) => console.error(err));
