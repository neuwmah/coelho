import { afterNextRender, Injectable, signal } from '@angular/core';

@Injectable({
  providedIn: 'root'
})
export class ThemeService {
  private readonly storageKey = 'portfolio-theme';

  readonly dark = signal(false);

  constructor() {
    afterNextRender(() => {
      this.apply(this.readStored());
    });
  }

  toggle(): void {
    this.apply(!this.dark());
  }

  private readStored(): boolean {
    return localStorage.getItem(this.storageKey) === 'dark';
  }

  private apply(dark: boolean): void {
    this.dark.set(dark);
    document.documentElement.dataset['theme'] = dark ? 'dark' : 'light';
    localStorage.setItem(this.storageKey, dark ? 'dark' : 'light');
    document.querySelector('meta[name="theme-color"]')?.setAttribute('content', dark ? '#12182a' : '#FFFFFF');
  }
}
