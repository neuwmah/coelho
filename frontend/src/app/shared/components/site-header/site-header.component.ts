import { afterNextRender, Component, DestroyRef, inject, signal } from '@angular/core';
import { SectionScrollService } from '../../../core/services/section-scroll.service';
import { ThemeService } from '../../../core/services/theme.service';

@Component({
  selector: 'app-site-header',
  standalone: true,
  templateUrl: './site-header.component.html',
  styleUrl: './site-header.component.scss',
  host: {
    '[class.is-scrolled]': 'scrolled()'
  }
})
export class SiteHeaderComponent {
  private readonly sectionScroll = inject(SectionScrollService);
  readonly theme = inject(ThemeService);

  readonly scrolled = signal(false);

  constructor() {
    const destroyRef = inject(DestroyRef);

    afterNextRender(() => {
      const onScroll = (): void => {
        this.scrolled.set(window.scrollY > 0);
      };

      onScroll();
      window.addEventListener('scroll', onScroll, { passive: true });
      destroyRef.onDestroy(() => window.removeEventListener('scroll', onScroll));
    });
  }

  goHome(event: Event): void {
    event.preventDefault();
    history.replaceState(null, '', '/');
    this.sectionScroll.scrollToTop('smooth');
  }

  goSection(fragment: string, event: Event): void {
    event.preventDefault();
    void this.sectionScroll.scrollToSection(fragment, 'smooth');
  }
}
