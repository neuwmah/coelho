import { Injectable } from '@angular/core';

@Injectable({
  providedIn: 'root'
})
export class SectionScrollService {
  private readonly pendingHashKey = 'portfolio-pending-hash';

  consumePendingHash(): string | null {
    const fromStorage = sessionStorage.getItem(this.pendingHashKey);
    if (fromStorage) {
      sessionStorage.removeItem(this.pendingHashKey);
      return fromStorage;
    }

    const fromLocation = window.location.hash.replace('#', '');
    return fromLocation || null;
  }

  scrollToTop(behavior: ScrollBehavior = 'smooth'): void {
    window.scrollTo({ top: 0, behavior });
  }

  async scrollToSection(fragment: string, behavior: ScrollBehavior = 'smooth'): Promise<boolean> {
    const element = await this.waitForSection(fragment);
    if (!element) {
      return false;
    }

    await this.waitForLayout(element);
    this.applyScroll(element, behavior);

    await new Promise<void>((resolve) => {
      requestAnimationFrame(() => {
        requestAnimationFrame(() => {
          this.applyScroll(element, 'auto');
          resolve();
        });
      });
    });

    history.replaceState(null, '', `/#${fragment}`);
    return true;
  }

  private applyScroll(element: HTMLElement, behavior: ScrollBehavior): void {
    const margin = Number.parseFloat(getComputedStyle(element).scrollMarginTop) || 0;
    const top = element.getBoundingClientRect().top + window.scrollY - margin;
    window.scrollTo({ top: Math.max(0, top), behavior });
  }

  private waitForSection(fragment: string, timeoutMs = 8000): Promise<HTMLElement | null> {
    const existing = document.getElementById(fragment);
    if (existing) {
      return Promise.resolve(existing);
    }

    return new Promise((resolve) => {
      const timeoutId = window.setTimeout(() => {
        observer.disconnect();
        resolve(document.getElementById(fragment));
      }, timeoutMs);

      const observer = new MutationObserver(() => {
        const element = document.getElementById(fragment);
        if (element) {
          window.clearTimeout(timeoutId);
          observer.disconnect();
          resolve(element);
        }
      });

      observer.observe(document.body, { childList: true, subtree: true });
    });
  }

  private async waitForLayout(element: HTMLElement): Promise<void> {
    if (document.readyState !== 'complete') {
      await new Promise<void>((resolve) => {
        window.addEventListener('load', () => resolve(), { once: true });
      });
    }

    if (document.fonts?.ready) {
      await document.fonts.ready;
    }

    const images = Array.from(document.querySelectorAll('img'));
    await Promise.all(
      images.map(async (image) => {
        if (!image.complete) {
          await new Promise<void>((resolve) => {
            image.addEventListener('load', () => resolve(), { once: true });
            image.addEventListener('error', () => resolve(), { once: true });
          });
        }

        if (typeof image.decode === 'function') {
          try {
            await image.decode();
          } catch {
            return;
          }
        }
      })
    );

    await new Promise<void>((resolve) => {
      requestAnimationFrame(() => {
        requestAnimationFrame(() => resolve());
      });
    });
  }
}
